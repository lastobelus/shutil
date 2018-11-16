module Shutil
  module Workers
    module Shopify
      extend ActiveSupport::Autoload

      autoload :ProductCacheWorker

      def self.slow_retry(count)
        (count ** count * 15) + 1.minute + (rand(60) * (count + 1))
      end

      def self.very_slow_retry(count)
        (count ** count * 15) + 1.minute + (rand(60) * (count + 1))
      end
    end
  end
end
