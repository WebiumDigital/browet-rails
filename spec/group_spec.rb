require "spec_helper"

RSpec.describe Browet::Group do
  include EntityHelpers

  context "when correct config" do
    before(:example) do
      group_init
    end

    it "responds to list" do
      groups = Browet::Group.list
      expect(groups).to be_a(Browet::ResultSet)
      should_be_group_1 groups[0]
      should_be_group_2 groups[1]
    end

    it "responds to get 1" do
      should_be_group_1 Browet::Group.get('group1')
    end

    it "responds to get 2" do
      should_be_group_2 Browet::Group.get('group2')
    end

    it "has group 1 containing products" do
      should_be_unpaged_set Browet::Group.get('group1').products
    end

    it "has group 1 containing paged products" do
      should_be_paged_set Browet::Group.get('group1').products(2, 2)
    end

  end

end
