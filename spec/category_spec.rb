require "spec_helper"

RSpec.describe Browet::Category do
  include EntityHelpers

  context "when correct config" do
    before(:example) do
      category_init
    end

    it "responds to get 1" do
      should_be_category_1 Browet::Category.get_by_slug('category1')
    end

    it "responds to get 2" do
      should_be_category_2 Browet::Category.get_by_slug('category2')
    end

    it "responds to get 3" do
      should_be_category_3 Browet::Category.get_by_slug('category3')
    end

    it "not respond to list" do
      expect { Browet::Category.list }.to raise_error(NoMethodError)
    end

    it "has category 1 containing products" do
      should_be_unpaged_set Browet::Category.get_by_slug('category1').products
    end

    it "has category 1 containing paged products" do
      should_be_paged_set Browet::Category.get_by_slug('category1').products(2, 2)
    end
  end

end