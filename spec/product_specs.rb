require "spec_helper"

RSpec.describe Browet::Product do
  include EntityHelpers

  context "when correct config" do
    before(:context) do
      product_init
    end

    it "responds to get 1" do
      category = Browet::Product.get(1)
      should_be_category_1(category)
    end

    it "responds to get 2" do
      category = Browet::Product.get(2)
      should_be_category_2(category)
    end

    it "responds to get 3" do
      category = Browet::Product.get(3)
      should_be_category_3(category)
    end

    it "responds to list" do
      should_be_unpaged_set Browet::Product
    end

    it "has group 1 containing paged products" do
      should_be_paged_set Browet::Group.get(1)
    end

  end

end
