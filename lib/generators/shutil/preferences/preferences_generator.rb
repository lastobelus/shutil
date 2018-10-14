module Shutil
  module Generators
    class PreferencesGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def preferences_resource
        route("resource :preferences, only:[:edit, :update]")
        copy_file "preferences_controller.rb", "app/controllers/preferences_controller.rb"
        copy_file "edit.html.slim", "app/views/preferences/edit.html.slim"
      end
    end
  end
end
