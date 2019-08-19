module Shutil
  module Csv
    module Exporters
      class Base
        attr_accessor :status, :num_records

        def self.filename
          name.demodulize.underscore.dasherize.gsub("-exporter", "")
        end

        def filename
          self.class.filename
        end

        def self.title
          filename.titleize
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

        def set_status_total
          @num_records = count
          total(@num_records)
        end

        def count
          raise "you must implement #{self.class.name}#count"
        end

        def data
          raise "you must implement #{self.class.name}#data"
        end

        def data
          raise "you must implement #{self.class.name}#headers"
        end

        def export_stream
          Shutil::Csv::CsvBuilder.csv_enumerator(headers: headers, data: data)
        end
      end
    end
  end
end
