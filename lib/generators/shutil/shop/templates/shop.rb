class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  include Shops::AdminLinks

  jsonb_accessor :preferences,
    setup: [:boolean, default: false],
    example_preference: [:string, default: "An Example Preference"]

  def start_shopify_session(opts = {}, &block)
    @shopify_session ||= begin
      session = ShopifyAPI::Session.new(self.shopify_domain, self.shopify_token)
      ShopifyAPI::Base.activate_session(session) if ShopifyAPI::Base.site.blank?
    end

    yield if block_given?
    self
  end

  def with_shopify_session
    ShopifyAPI::Session.temp(shopify_domain, shopify_token) do
      yield
    end
  end

  def update_users
    shopify_users = with_shopify_session { ShopifyAPI::User.all }
    shopify_users.each do |shopify_user|
      begin
        user = nil
        User.transaction(requires_new: true) do
          user = users.find_or_create_by(shopify_user_id: shopify_user.id)
        end
        user.update(shopify_user.attributes.slice(:first_name, :last_name, :email))
      rescue ActiveRecord::RecordNotUnique
        retry
      end
    end
  end
end
