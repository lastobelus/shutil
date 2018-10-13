require "shutil/engine"
require "action_view"
require "action_pack"

module Shutil
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Workers
  end

  class << self
    def eager_load!
      super
      Shutil::Workers.eager_load!
    end

    attr_reader :config

    def configure
      @config = Configuration.new
      yield config
    end
  end
end
