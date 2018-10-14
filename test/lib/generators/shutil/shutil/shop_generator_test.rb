require 'test_helper'
require 'generators/shutil/shop/shop_generator'

module Shutil
  class Shutil::ShopGeneratorTest < Rails::Generators::TestCase
    tests Shutil::ShopGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
