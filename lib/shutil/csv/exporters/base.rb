module Shutil
  module Csv
    module Exporters
      class Base
        attr_accessor :status

        def self.filename
          name.demodulize.underscore.dasherize.gsub("-exporter", "")
        end

        def filename
          self.class.filename
        end

        def self.title
          name.demodulize.titleize.gsub(" Exporter", "")
        end

        def title
          self.class.title
        end

        def self.id
          name.demodulize.underscore
        end

        def id
          self.class.id
        end

        def at(x, msg)
          status&.at(x, msg)
        end

        def total(x)
          status&.total(x)
        end
      end
    end
  end
end
