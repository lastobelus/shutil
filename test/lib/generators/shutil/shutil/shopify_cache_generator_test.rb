require 'test_helper'
require 'generators/shutil/shopify_cache/shopify_cache_generator'

module Shutil
  class Shutil::ShopifyCacheGeneratorTest < Rails::Generators::TestCase
    tests Shutil::ShopifyCacheGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
