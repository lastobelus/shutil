module Shutil
  module CLI
    class TBox
      attr_accessor :width, :padding, :openleft
      attr_reader :colors, :text_colors

      def initialize(width:, colors: [], text_colors: [], padding: 1, openleft: false)
        @width = width
        @colors = [colors].flatten
        @text_colors = [text_colors].flatten
        @padding = padding
        @openleft = openleft
      end

      def colors=(*colors)
        @colors = [colors].flatten
      end

      def text_colors=(*colors)
        @text_colors = [colors].flatten
      end

      def c(*args)
        Chrome.c(*args)
      end

      def top
        l = openleft ? "━" : "┏"
        puts c(l + ("━" * (width - 2)) + "┓", *colors)
      end

      def bottom
        l = openleft ? "━" : "┗"
        puts c(l + ("━" * (width - 2)) + "┛", *colors)
      end

      def bottom_open
        l = openleft ? "━" : "┣"
        puts c(l + ("━" * (width - 2)) + "┛", *colors)
      end

      def hordiv
        l = openleft ? "━" : "┣"
        puts c(l + ("━" * (width - 2)) + "┫", *colors)
      end

      def leftwall
        openleft ? c(" ", *text_colors) : c("┃", *colors)
      end

      def blank
        center("")
      end

      def padding
        [@padding.to_i, 0].max
      end

      def padchars
        " " * padding
      end

      def center(msg)
        puts leftwall +
          c(padchars +
          Chrome.center(msg, width - 2 - padding - padding) + padchars, *text_colors) +
          c("┃", *colors)
      end

      def left(msg)
        puts leftwall +
          c(padchars +
          Chrome.ljust(msg, width - 2 - padding - padding) + padchars, *text_colors) +
          c("┃", *colors) +
          " "
      end

      def right(msg)
        puts leftwall +
          c(padchars +
          Chrome.rjust(msg, width - 2 - padding - padding) +
          padchars, *text_colors) +
          c("┃", *colors)
      end

      def in_box(justification, *lines, **opts)
        top
        lines.each {|line| send(justification, line) }
        bottom
      end
    end
  end
end