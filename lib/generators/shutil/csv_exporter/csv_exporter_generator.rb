class Shutil::CsvExporterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  class_option :headers, type: "array", required: true, aliases: "-h"
  class_option :opts, type: "array", required: false, aliases: "-o"

  def exporter
    puts "file_name: #{file_name.inspect}"
    puts "class_name: #{class_name.inspect}"
    template "exporter.rb", "app/models/csv_exporters/#{file_name}.rb"
  end

  private

  def file_name
    super.ends_with?("_exporter") ? super : "#{super}_exporter"
  end

  def exporter_id
    singular_name
  end

  def headers
    options["headers"].map { |h| h.gsub(/[,;"']/, "").strip }.join("\n      ")
  end

  def opts
    opts_with_shop = ["shop"]
    opts_with_shop.concat(options["opts"]) unless options["opts"].blank?
  end

  def opt_name(opt)
    opt.strip.underscore.downcase
  end

  def opt_name_to_sym(opt)
    opt_name(opt).to_sym.inspect
  end

  def opts_names
    opts.map { |o| o.split(/ *= */).first }
  end

  def initializer
    opts_defaults = opts.select { |o| o.include?("=") }.map { |o| o.split(/ *= */) }.map { |o| [opt_name(o.first), o.second].join(" = ") }

    %Q(
    aattr_initialize [#{opts_names.map { |o| ":#{o}" }.join(", ")}] do
      #{opts_defaults.join("\n      ")}
    end
    )
  end

  def permitted_opts
    if opts.present?
      %Q{
    def self.permitted_opts
      %i(#{opts_names.map { |o| o.gsub("!", "") }.join(" ")})
    end
    def self.opts?; true; end
      }
    else
      %Q{
    def self.opts?; false; end
      }
    end
  end

  def filename
    %Q(
    # To override the default filename, implement this.
    # def filename
    #   ...
    # end
    )
  end

  def title
    %Q(
    # To override the default title, implement this.
    # def title
    #   ...
    # end
    )
  end
end
