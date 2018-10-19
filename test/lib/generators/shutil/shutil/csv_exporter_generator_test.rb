require 'test_helper'
require 'generators/shutil/csv_exporter/csv_exporter_generator'

module Shutil
  class Shutil::CsvExporterGeneratorTest < Rails::Generators::TestCase
    tests Shutil::CsvExporterGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
