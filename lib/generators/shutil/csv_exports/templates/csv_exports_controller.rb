class CsvExportsController < ApplicationController
  include ShopifyApp::AuthenticatedByShopify
  # GET /csv_exports/name.csv
  def show
    respond_to do |format|
      format.csv do
        begin
          klass = exporter_klass(params[:id])
        rescue NameError
          raise "no csv export for #{params[:id]}"
        end

        if klass.opts?
          opts = params.require(params[:id].to_sym).permit(klass.permitted_opts)
          exporter = klass.new(opts)
        else
          exporter = klass.new
        end

        filename = exporter.respond_to?(:filename) ? exporter.filename : "#{params[:id]}-export"

        stream_csv(
          filename: csv_filename(filename),
          stream: exporter.export_stream,
        )
      end
    end
  end

  def index
    @csv_exports = CsvExporters.available_exporters
  end

  private

  def exporter_klass(id)
    name = id.camelize
    name = "#{name}Exporter" unless name.ends_with?("Exporter")
    "CsvExporters::#{name}".constantize
  end

  def stream_resource(stream)
    headers["X-Accel-Buffering"] = "no"
    headers["Cache-Control"] = "no-cache"
    self.response_body = stream
  end

  def csv_filename(basename)
    "#{basename}-#{Time.zone.now.to_date.to_s(:default)}.csv"
  end

  def stream_csv(filename:, stream:)
    headers["Content-Type"] = "text/csv; charset=utf-8"
    headers["Content-Disposition"] = %{attachment; filename="#{filename}"}
    stream_resource stream
  end
end
