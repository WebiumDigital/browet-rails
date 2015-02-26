require "spec_helper"

RSpec.describe Browet::Product do
  include EntityHelpers

  context "when correct config" do
    before(:example) do
      config_init
      product_init
    end

    it "responds to get 1" do
      should_be_product_1 Browet::Product.get('product1')
    end

    it "responds to get 2" do
      should_be_product_2 Browet::Product.get('product2')
    end

    it "responds to get 3" do
      should_be_product_3 Browet::Product.get('product3')
    end

    it "responds to list" do
      should_be_unpaged_set Browet::Product.list
    end

    it "responds to list paged" do
      should_be_paged_set Browet::Product.list(2,2)
    end

    it "responds to find" do
      should_be_find_set Browet::Product.find({title: 'product title 1'})
    end
  end

end
