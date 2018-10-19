
module Shutil
  module ShopifyExtensions
    extend ActiveSupport::Autoload

    autoload :ObjectCache
    autoload :Stream

    def self.eager_load!
      super
    end
  end
end
