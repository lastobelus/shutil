module Shutil
  module Generators
    class StylesGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_styles
        remove_file "app/assets/stylesheets/application.css"
        directory "./stylesheets", "app/assets/stylesheets"
        directory "./images", "app/assets/images"
      end

      private
    end
  end
end
