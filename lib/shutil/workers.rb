module Shutil
  module Workers
    extend ActiveSupport::Autoload

    autoload :Utilities

    def self.eager_load!
      super
      Shutil::Workers::Utilities.eager_load!
    end

  end
end