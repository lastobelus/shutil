module Shutil
  class CsvImportsController < ApplicationController
    include ShopifyApp::AuthenticatedByShopify

    # POST /csv_imports
    # POST /csv_imports.json
    def create
      @csv_import = current_shop.csv_imports.build(csv_import_params)
      respond_to do |format|
        if @csv_import.save && @csv_import.process
          format.html { redirect_to return_path, notice: "CSV was uploaded & is being imported." }
          format.json { render :show, status: :created, location: @csv_import }
        else
          Rails.logger.debug { "errors: #{@csv_import.errors.full_messages.join(", ")}" }
          format.html { redirect_to return_path, flash: {error: @csv_import.errors.full_messages.join(", ")} }
          format.json { render json: @csv_import.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def csv_import_params
      params.require(:csv_import).permit(:file, :processor)
    end

    def return_path
      csv_imports_path(anchor: params[:return_anchor])
    end
  end
end
