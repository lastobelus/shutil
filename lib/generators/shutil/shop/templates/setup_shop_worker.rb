class SetupShopWorker
  include Sidekiq::Worker

  attr_accessor :shop

  def perform(shop_id)
    self.shop = Shop.find(shop_id)
    Rails.logger.debug { "----------------------- Setting up #{shop.shopify_domain}------------------------" }
    shop.setup = true
    shop.save!
  end
end
