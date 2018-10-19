require 'test_helper'
require 'generators/shutil/csv_exports/csv_exports_generator'

module Shutil
  class Shutil::CsvExportsGeneratorTest < Rails::Generators::TestCase
    tests Shutil::CsvExportsGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
