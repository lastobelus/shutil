module Shutil
  class Configuration
    attr_writer :application_record_classname

    def application_record_classname
      @application_record_classname || "ApplicationRecord"
    end
  end
end
