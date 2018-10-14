module ShopifyApp
  module AuthenticatedByShopify
    extend ActiveSupport::Concern

    included do
      include ShopifyApp::Localization
      include ShopifyApp::LoginProtection
      include ShopifyApp::EmbeddedApp

      protect_from_forgery with: :exception
      before_action :login_again_if_different_shop
      around_action :shopify_session
      before_action :setup_shop, except: [:setup]
      helper_method :current_shop
    end

    protected

    def current_shop
      return nil unless shop_session
      @current_shop = nil if @current_shop&.shopify_domain != shop_session.url
      @current_shop ||= Shop.where(shopify_domain: shop_session.url).first
    end

    def setup_shop
      return true if current_shop&.setup?
      if current_shop
        SetupShopWorker.perform_async(current_shop.id)
        redirect_to setup_url
        false
      end
    end
  end
end
