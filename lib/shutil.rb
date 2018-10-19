require "shutil/engine"
require "action_view"
require "action_pack"
require "shutil/configuration"

module Shutil
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Workers
    autoload :ShopifyExtensions
  end

  class << self
    def eager_load!
      super
      Shutil::Workers.eager_load!
      Shutil::ShopifyExtensions.eager_load!
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
