module Shutil
  module Csv
    class CsvBuilder
      aattr_initialize [:headers, :data, :output] do
        @output ||= ""
      end

      def build
        output << CSV.generate_line(headers)
        data.each do |row|
          output << CSV.generate_line(row)
        end
        output
      end

      def self.csv_enumerator(headers:, data:)
        Enumerator.new do |yielder|
          new(headers: headers, data: data, output: yielder).build
        end
      end
    end
  end
end
