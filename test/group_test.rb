require 'test_helper'
require "browet/group"

class Browet::GroupTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'categories_groups', json_string('groups')
    stub_get_request 'categories_groups/1', json_string('group1')
  end

  test "for valid list response" do
    groups = Browet::Group.list
    assert_kind_of Array, groups

    group0 = groups[0]
    assert_instance_of Browet::Group, group0
    assert_equal 1, group0.id, 'Invalid group id'
    assert_equal 'group title 1', group0.title, 'Invalid group title'
    assert_equal 'group name 1', group0.name, 'Invalid group name'
    assert_kind_of Array, group0.categories
    assert_not_empty group0.categories

    group2 = groups[2]
    assert_instance_of Browet::Group, group2
    assert_equal 3, group2.id, 'Invalid group id'
    assert_equal 'group title 3', group2.title, 'Invalid group title'
    assert_equal 'group name 3', group2.name, 'Invalid group name'
    assert_kind_of Array, group2.categories
    assert_empty group2.categories
  end

  test "for valid get response" do
    group = Browet::Group.get(1)
    
    assert_kind_of Browet::Group, group
    assert_equal 1, group.id, 'Invalid group id'
    assert_equal 'group title 1', group.title, 'Invalid group title'
    assert_equal 'group name 1', group.name, 'Invalid group name'
    
    assert_kind_of Array, group.categories
    category0 = group.categories[0]
    assert_equal 1, category0.id, 'Invalid category id'
    assert_equal 'root_categories title 1', category0.title, 'Invalid category title'
    assert_nil category0.parent_id, 'Invalid parent_id name'
    assert_equal 1, category0.group_id, 'Invalid category group id'
    assert_kind_of Array, category0.subcategories
    subcategory0 = category0.subcategories[0]
    assert_equal 3, subcategory0.id, 'Invalid category id'
    assert_equal 'root_categories title 3', subcategory0.title, 'Invalid category title'
    assert_equal 1, subcategory0.parent_id, 'Invalid category parent_id name'
    assert_equal 1, subcategory0.group_id, 'Invalid category group id'

    category1 = group.categories[1]
    assert_equal 2, category1.id, 'Invalid category id'
    assert_equal 'root_categories title 2', category1.title, 'Invalid category title'
    assert_nil category1.parent_id, 'Invalid parent_id name'
    assert_equal 1, category1.group_id, 'Invalid category group id'
    assert_kind_of Array, category1.subcategories
    assert_empty category1.subcategories
  end

end
