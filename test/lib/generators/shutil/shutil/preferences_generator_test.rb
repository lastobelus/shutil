require 'test_helper'
require 'generators/shutil/preferences/preferences_generator'

module Shutil
  class Shutil::PreferencesGeneratorTest < Rails::Generators::TestCase
    tests Shutil::PreferencesGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
