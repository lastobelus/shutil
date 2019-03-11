module Shutil
  class CsvImport < Shutil.config.application_record_classname.constantize
    self.table_name = "csv_imports"

    belongs_to :shop
    validates :processor, presence: true
    validate :valid_processor?

    def initialize(params = {})
      file = params.delete(:file)
      roo_opts = params.delete(:roo_opts) || {}
      super
      if file
        self.filename = sanitize_filename(file.original_filename)
        self.content_type = file.content_type
        spreadsheet = Roo::Excelx.open(file.tempfile, roo_opts)
        self.file_data = spreadsheet.to_csv
      end
    end

    def process
      processor.constantize.perform_async(id)
      update_attribute(:state, "queued")
    end

    def valid_processor?
      unless processor_klass.method_defined?(:perform)
        errors.add(:processor, "has no perform method")
      end
    rescue NameError
      errors.add(:processor, "'#{processor}' does not exist")
    end

    def processor_klass
      processor.constantize
    end

    def processor_instance
      processor_klass.constantize.new
    end

    def record_count()
      file_data.lines.count
    end

    private

    def sanitize_filename(filename_or_path)
      File.basename(filename_or_path)
    end
  end
end
