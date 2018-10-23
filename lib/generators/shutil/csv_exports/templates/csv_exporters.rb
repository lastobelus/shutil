module CsvExporters
  def self.available_exporters
    constants.select { |c| c.to_s.ends_with?("Exporter") }.map { |c| const_get(c) }
  end
end
