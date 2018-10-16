require 'test_helper'
require 'generators/javascript/javascript_generator'

module Shutil
  class JavascriptGeneratorTest < Rails::Generators::TestCase
    tests JavascriptGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
