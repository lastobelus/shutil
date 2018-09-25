require "shutil/engine"
require 'action_view'
require 'action_pack'

module Shutil
  extend ActiveSupport::Autoload


  eager_autoload do
    autoload :Workers
  end

  def self.eager_load!
    super
    Shutil::Workers.eager_load!
  end

end
