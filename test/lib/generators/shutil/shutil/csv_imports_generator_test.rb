require 'test_helper'
require 'generators/shutil/csv_imports/csv_imports_generator'

module Shutil
  class Shutil::CsvImportsGeneratorTest < Rails::Generators::TestCase
    tests Shutil::CsvImportsGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
