module Shutil
  module Workers
    module Utilities
      class HelloWorldWorker
        include ::Sidekiq::Worker
        include ::Sidekiq::Status::Worker

        sidekiq_options retry: false

        def perform(shop_id)
          at 1, "hello world"
          shop = Shop.find(shop_id)

          product_count = nil

          shop.with_shopify_session do
            product_count = ShopifyAPI::Product.count
          end

          at 100, "Product Count: #{product_count.inspect}"
        end

      end
    end
  end
end
