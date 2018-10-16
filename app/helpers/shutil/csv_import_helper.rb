module Shutil
  module CsvImportHelper
    def last_csv_import(processor)
      current_shop.csv_imports.where(processor: processor).order(created_at: :desc).first
    end

    def csv_import_state_bg(csv_import)
      case csv_import.state
      when "finished"
        "bg-success text-white"
      when "error"
        "bg-danger text-white"
      when "processing"
        "bg-faded"
      else
        ""
      end
    end
  end
end
