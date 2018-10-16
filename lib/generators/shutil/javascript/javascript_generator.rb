module Shutil
  class JavascriptGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def utilities
      directory "global", "app/javascript/"
    end
  end
end
