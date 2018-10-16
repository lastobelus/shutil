module Shutil
  module Csv
    module CsvImportWorker
      def with_csv(csv_import)
        sio = StringIO.new(csv_import.file_data)
        sio.set_encoding Encoding::UTF_8
        SmarterCSV.process(sio, csv_options) do |row|
          yield row
        end
      end

      def finish(csv_import, message)
        message = [csv_import.info, message].flatten.join("\n")
        csv_import.update(
          finished_processing_at: Time.now,
          info: message,
          state: "finished",
        )
      end

      def error!(csv_import, errors)
        message = [csv_import.info, "", "ERROR:", errors, "", ""].flatten.join("\n")
        csv_import.update(
          info: message,
        )
      end

      def info(csv_import, message)
        message = [csv_import.info, message].flatten.join("\n")
        csv_import.update(
          info: message,
        )
      end

      def load_csv_import_id(csv_import_id)
        csv_import = CsvImport.find(csv_import_id)
        csv_import.state = "processing"
        csv_import.started_processing_at = Time.now
        csv_import.save!
        csv_import
      end

      def cancelled?
        Sidekiq.redis { |c| c.exists("cancelled-#{jid}") }
      end

      def self.cancel!(jid)
        return if jid.blank?
        Sidekiq.redis { |c| c.setex("cancelled-#{jid}", 86400, 1) }
      end

      def import_fixture(path)
        path = Rails.root.join(path) unless path.starts_with?("/")
        file = Rack::Test::UploadedFile.new(path)
        csv_import = CsvImport.create!(shop: @shop, file: file, roo_opts: {extension: :xlsx}, processor: self.class.name)
        perform(csv_import.id)
      end
    end
  end
end
