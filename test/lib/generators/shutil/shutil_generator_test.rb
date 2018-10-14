require 'test_helper'
require 'generators/shutil/shutil_generator'

module Shutil
  class ShutilGeneratorTest < Rails::Generators::TestCase
    tests ShutilGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
