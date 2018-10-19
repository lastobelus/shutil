module Shutil
  class Engine < ::Rails::Engine
    isolate_namespace Shutil

    config.to_prepare do
      ShopifyAPI::Base.extend(Shutil::ShopifyExtensions::Stream)
      if Shutil.config
        # Example of adding an association to app class
        # Shutil.config.user_class.constantize.class_eval do
        #   has_many :campaigns, class_name: 'Shutil::Campaign'
        # end
        #
        # Another option would be to use a module
        # module Shutil
        #   module Models
        #     module Campaigner
        #       def included(klass)
        #         klass.class_eval do
        #           has_many :campaigns, class_name: 'Shutil::Campaign'
        #         end
        #       end
        #     end
        #   end
        # end
        #
        # To be used in app with:
        # class User < ActiveRecord::Base
        #   include Shutil::Models::Campaigner
        # end

      end
    end
  end
end
