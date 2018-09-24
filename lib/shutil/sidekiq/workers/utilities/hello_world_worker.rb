class Shutil::Sidekiq::Utilities::HelloWorldWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: false

  def perform(shop_id)
    at 1, "hello world"
    shop = Shop.find(shop_id)

    product_count = nil

    with_shopify_session do
      product_count = ShopifyAPI::Product.count
    end

    at 100, "Product Count: #{product_count.inspect}"
  end
end
