require 'shutil/cli/thor'
require 'shutil/cli/chrome'
require 'shutil/cli/tbox'

module Shutil
  module CLI
    class << self
      def error(msg)
        puts Chrome.c("#{Chrome.red_x} #{msg}", :red)
      end

      def exit_with_error(msg)
        error(msg)
        exit 1
      end

      def exit_with_exception(msg)
        error(msg)
        raise
      end
    end
  end
end
