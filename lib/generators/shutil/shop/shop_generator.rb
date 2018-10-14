module Shutil
  module Generators
    class ShopGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def shop_model
        template "shop.rb", "app/models/shop.rb"
        template "admin_links.rb", "app/models/shops/admin_links.rb"
      end

      def wait_for_setup
        route("get '/setup', to: 'home#setup'")
        route("get '/home', to: 'home#index'")
        template "setup_shop_worker.rb", "app/workers/setup_shop_worker.rb"
        template "setup.html.slim", "app/views/home/setup.html.slim"
      end
    end
  end
end
