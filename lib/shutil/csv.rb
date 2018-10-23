module Shutil
  module Csv
    extend ActiveSupport::Autoload

    autoload :Exporters

    def self.eager_load!
      super
      Shutil::Csv::Exporters.eager_load!
    end
  end
end
