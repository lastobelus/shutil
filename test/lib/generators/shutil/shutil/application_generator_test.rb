require 'test_helper'
require 'generators/shutil/application/application_generator'

module Shutil
  class Shutil::ApplicationGeneratorTest < Rails::Generators::TestCase
    tests Shutil::ApplicationGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
