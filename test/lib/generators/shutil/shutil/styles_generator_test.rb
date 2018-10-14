require 'test_helper'
require 'generators/shutil/styles/styles_generator'

module Shutil
  class Shutil::StylesGeneratorTest < Rails::Generators::TestCase
    tests Shutil::StylesGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
