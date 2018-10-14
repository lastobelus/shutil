module Shutil
  module Generators
    class ShutilGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def initialize(args, *options)
        @opts = options.first
        super(args, *options)
      end

      def run_all_generators
        generate "shutil:application"
        generate "shutil:shop"
        generate "shutil:preferences"
        generate "shutil:styles"
        generate "shutil:layout"
        generate "shutil:menu"
      end
    end
  end
end
