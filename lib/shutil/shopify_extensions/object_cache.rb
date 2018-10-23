module Shutil
  module ShopifyExtensions
    class ObjectCache < Shutil.config.application_record_classname.constantize
      class_attribute :caches_data
      class_attribute :caches_children
      class_attribute :attributes_cached
      class_attribute :data_attributes_cached

      def self.cache_attributes(*args)
        self.attributes_cached = args
      end

      def self.attributes_from_shopify
        @attributes_from_shopify ||= attributes_cached.map { |a| a.to_s.gsub(/^shopify_/, "") }
      end

      def self.cache_data_attributes(*args)
        self.data_attributes_cached = args
      end

      def self.cache_data(state)
        self.caches_data = !!state
      end

      def self.caches_data?
        self.caches_data || !data_attributes_cached.blank?
      end

      def self.cache_children(*args)
        self.caches_children = args
      end

      def self.caches_children?
        !self.caches_children.blank?
      end

      def fetch_shopify_object
        shop.with_shopify_session { self.class.shopify_class.find(id) }
      end

      def new_shopify_instance
        self.class.shopify_class.new(id: id)
      end

      def self.shopify_class
        ShopifyAPI.const_get(self.name.gsub(/^Shopify/, ""))
      end

      def shopify_class
        self.class.shopify_class
      end

      def process_update(shopify_obj)
        puts "process_update attributes_cached: #{self.class.attributes_cached.inspect}"

        self.attributes = attributes_for_record(shopify_obj)
      end

      def attributes_for_record(shopify_obj)
        Hash[
          self.class.attributes_cached.zip(
            self.class.attributes_from_shopify.map { |attr| shopify_obj.attributes[attr] }
          )
        ]
      end

      def attributes_for_data(shopify_obj)
        #OPTIMIZE
        shopify_hash = JSON.parse(shopify_obj.to_json)
        attrs = self.class.data_attributes_cached
        if attrs.nil? || attrs.empty? || attrs == :all
          shopify_hash.except(*self.class.attributes_cached.map(&:to_s))
        else
          shopify_hash.slice(*attrs.map(&:to_s))
        end
      end

      def update_children_from_shopify_obj(shopify_obj, shop)
        if caches_children?
          caches_children.each do |child_obj_name|
            # byebug
            children = shopify_obj.attributes.delete(child_obj_name.to_s)
            children = [children] unless children.is_a?(Array)
            cache_klass = "Shopify#{children.first.class.name.demodulize}".constantize
            children.each do |child_shopify_obj|
              cache_klass.update_from_shopify_obj(shop, child_shopify_obj, self)
            end
          end
        end
      end

      def cache_data_from_shopify_obj(shopify_obj)
        if caches_data?
          self.shopify_data = self.attributes_for_data(shopify_obj)
        end
      end

      def self.create_from_shopify_obj!(shop, shopify_obj, parent_attrs = {})
        find(shopify_obj.id)
      rescue ActiveRecord::RecordNotFound
        transaction(requires_new: true) do
          create!(parent_attrs.merge(id: shopify_obj.id, shop: shop))
        end
      rescue ActiveRecord::RecordNotUnique
        find(shopify_obj.id)
      end

      def self.update_from_shopify_obj(shop, shopify_obj, parent_record = nil)
        parent_attrs = {}
        if parent_record
          parent_attrs["#{parent_record.model_name.singular}_id"] = parent_record.id
        end
        model = create_from_shopify_obj!(shop, shopify_obj, parent_attrs)
        model.process_update(shopify_obj)
        model.cache_data_from_shopify_obj(shopify_obj)
        model.save!
        model.update_children_from_shopify_obj(shopify_obj, shop)
        model
      end

      def self.shopify_fields_for_fetch
        fields = attributes_from_shopify + ["id"]
        fields.concat(caches_children) if caches_children?
        fields
      end

      def self.update_all(shop)
        errors = []
        shopify_class.stream(shop: shop, params: {fields: shopify_fields_for_fetch}).each do |shopify_obj|
          model = update_from_shopify_obj(shop, shopify_obj)
          errors << model.errors unless model.errors.blank?
        end
        errors
      end
    end
  end
end
