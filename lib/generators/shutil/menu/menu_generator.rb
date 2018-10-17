module Shutil
  module Generators
    class MenuGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def shopify_menu
        copy_file "_shopify_app_js.html.erb", "app/views/layouts/_shopify_app_js.html.erb"
        directory "menus", "app/views/layouts/menus"
      end
    end
  end
end
