require 'test_helper'
require 'generators/shutil/layout/layout_generator'

module Shutil
  class Shutil::LayoutGeneratorTest < Rails::Generators::TestCase
    tests Shutil::LayoutGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
