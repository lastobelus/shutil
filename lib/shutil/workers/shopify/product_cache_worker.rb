module Shutil
  module Workers
    module Shopify
      class ProductCacheWorker
        include ::Sidekiq::Worker
        include ::Sidekiq::Status::Worker

        sidekiq_options retry: false
      end
    end
  end
end
