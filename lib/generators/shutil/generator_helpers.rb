module Shutil
  module Generators
    module GeneratorHelpers
      def parent_app_name
        ::Rails.application.class.parent.name
      end
    end
  end
end
