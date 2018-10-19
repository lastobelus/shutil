module Shutil
  module Generators
    class ShopifyCacheGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
      include Rails::Generators::Migration

      argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"
      class_option :caches_data, type: :boolean, default: false, aliases: "-d"
      class_option :caches_children, type: :array, aliases: "-c"
      class_option :parent_object, type: :string, default: nil, aliases: "-r"

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S%L")
      end

      def model
        puts "options: #{options.inspect}"
        puts "file_name: #{file_name.inspect}"
        puts "class_name: #{class_name.inspect}"
        puts "singular_name: #{singular_name.inspect}"
        puts "attributes: #{attributes.inspect}"
        puts "attributes_names: #{attributes_names.inspect}"
        puts "shopify_name: #{shopify_name.inspect}"
        puts "migration_class_name: #{migration_class_name.inspect}"
        puts "caches_data?: #{caches_data?.inspect}"
        puts "parent_object: #{parent_object.inspect}"
        template "model.rb", "app/models/#{file_name}.rb"
      end

      def migration
        migration_template "migration.rb", "db/migrate/create_#{plural_table_name}.rb"
      end

      private

      def caches_data?
        options[:caches_data]
      end

      def caches_children
        options[:caches_children]
      end

      def parent_object
        options[:parent_object]
      end

      def file_name
        super.starts_with?("shopify") ? super : "shopify_#{super}"
      end

      def shopify_name
        file_name.sub(/^shopify_/, "")
      end

      def migration_class_name
        "Create#{class_name.pluralize}"
      end

      def attributes_with_index
        attributes.select { |a| !a.reference? && a.has_index? }
      end
    end
  end
end
