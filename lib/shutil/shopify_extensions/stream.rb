module Shutil
  module ShopifyExtensions
    module Stream
      def stream(shop:, params: {}, page_size: 250, gc: false)
        Enumerator.new do |yielder|
          page = 1
          pages = shop.with_shopify_session { (self.count.to_f / page_size).ceil }

          while page <= pages
            puts "fetching page #{page} with params #{params.merge(page: page, limit: page_size)}"
            results = shop.with_shopify_session { all(params: params.merge(page: page, limit: page_size)) }
            results.map { |item| yielder << item }
            page += 1
          end
        end.lazy
      end
    end
  end
end
