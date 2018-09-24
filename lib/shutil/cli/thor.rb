require 'thor'
unless defined? Thor::Shell::Color::UNDERLINE
  class Thor::Shell::Color
    UNDERLINE = "\e[4m".freeze
    ITALIC = "\e[3m".freeze
    STRIKETHROUGH = "\e[9m".freeze
  end

end

class Thor::Shell::Basic
  def ask_simply(statement, color, options)
    default = options[:default]
    message = [statement, ("(#{default})" if default), nil].uniq.join(" ")
    message = prepare_message(message, *color)
    result = Thor::LineEditor.readline(message, options)

    return unless result

    result.strip!

    if default && result == ""
      default
    else
      result
    end
  end
end
