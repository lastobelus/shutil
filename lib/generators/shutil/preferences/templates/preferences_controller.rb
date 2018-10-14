class PreferencesController < ApplicationController
  include ShopifyApp::AuthenticatedByShopify

  before_action :set_preferences

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @preferences.update(shop_params)
        prefs = shop_params.keys.map { |p| "'#{p.humanize.capitalize}'" }
        were = prefs.length > 1 ? "were" : "was"
        format.html { redirect_to root_path, notice: "#{prefs.join(", ")} #{were} successfully updated." }
        format.json { render :show, status: :ok, location: @preferences }
      else
        format.html { render :edit }
        format.json { render json: @preferences.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_preferences
    @preferences = current_shop
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def shop_params
    params.require(:shop).permit(
      :example_preference,
    )
  end
end
