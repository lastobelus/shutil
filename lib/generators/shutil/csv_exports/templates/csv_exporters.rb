module CsvExporters
  def self.available_exporters
    constants.select { |c| const_get(c).is_a? Class }
  end
end
