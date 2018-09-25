require_dependency "shutil/application_controller"

module Shutil
  class JobStatusController < ApplicationController
    def show
      data = Sidekiq::Status::get_all params[:id]
      render json: data
    end
  end
end
