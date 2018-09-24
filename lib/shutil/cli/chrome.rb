module Shutil
  module CLI
    module ChromeString

      def +(str)
        Chrome.s(super)
      end

      def c(*args)
        if args.first.to_s.include? Thor::Shell::Color::CLEAR
          args.first + self
        else
          thor.set_color(self, *args)
        end
      end

      def center(len, padchar=" ")
        Chrome.center(self, len, padchar)
      end

      def ljust(len, padchar=" ")
        Chrome.ljust(self, len, padchar)
      end

      def rjust(len, padchar=" ")
        Chrome.rjust(self, len, padchar)
      end
    end

    module Chrome
      class << self
        def thumbs_up
          "👍  "
        end

        def red_x
          "❌  "
        end

        def sepchar
          "\u2550"
        end

        def sep
          puts c(sepchar * 120, :white, :on_cyan)
          puts
        end

        def thor
          @thor ||= begin
            require 'thor'
            Thor::Shell::Color.new
          end
        end

        def chrome_string(msg)
          msg.extend ChromeString
          msg
        end
        alias_method :s, :chrome_string

        def c(*args)
          if args.first.to_s.include? Thor::Shell::Color::CLEAR
            args.first
          else
            chrome_string thor.set_color(*args)
          end
        end

        def print_result(*msgs)
          sep
          msgs = [msgs].flatten
          msgs.each {|msg| puts msg }
          puts
        end

        def underline(txt, clear: false)
          s = "\e[4m#{txt}"
          s += "\e[0m" if clear
          chrome_string s
        end

        def without_ansi(s)
          s.gsub(/\e\[[^m]*m/, "")
        end

        def center(msg, len, padchar=" ")
          msg_len = without_ansi(msg).length
          pad = [(len.to_f - msg_len) / 2, 0].max
          chrome_string(padchar * pad.floor) + msg + (padchar * pad.ceil)
        end

        def ljust(msg, len, padchar=" ")
          msg_len = without_ansi(msg).length
          pad = [len - msg_len, 0].max

          chrome_string msg + (padchar * pad.ceil)
        end

        def rjust(msg, len, padchar=" ")
          msg_len = without_ansi(msg).length
          pad = [len - msg_len, 0].max

          chrome_string (padchar * pad.ceil) + msg
        end
      end
    end
  end
end