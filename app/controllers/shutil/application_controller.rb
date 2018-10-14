module Shutil
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end

  protected

  def commish
    ENV.fetch("GIT_COMMIT", `git rev-parse HEAD`.chomp)
  end
end
