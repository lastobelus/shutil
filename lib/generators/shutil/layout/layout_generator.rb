require "generators/shutil/generator_helpers"

module Shutil
  module Generators
    class LayoutGenerator < Rails::Generators::Base
      include Shutil::Generators::GeneratorHelpers
      source_root File.expand_path("templates", __dir__)

      def application_template
        puts "parent_app_name: #{parent_app_name.inspect}"

        remove_file "app/views/layouts/application.html.erb"
        template "application.html.slim", "app/views/layouts/application.html.slim"
        remove_file "app/views/layouts/embedded_app.html.erb"
        template "embedded_app.html.slim", "app/views/layouts/embedded_app.html.slim"
        template "_debug_css.html.slim", "app/views/layouts/_debug_css.html.slim"
        copy_file "_flash_messages.html.erb", "app/views/layouts/_flash_messages.html.erb"
      end

      def layout_partials
        template "_ui_layout.html.slim", "app/views/layouts/_ui_layout.html.slim"
        template "_ui_card.html.slim", "app/views/layouts/_ui_card.html.slim"
      end
    end
  end
end
