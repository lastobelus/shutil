require 'test_helper'
require 'generators/shutil/menu/menu_generator'

module Shutil
  class Shutil::MenuGeneratorTest < Rails::Generators::TestCase
    tests Shutil::MenuGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
