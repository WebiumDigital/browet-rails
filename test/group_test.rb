require 'test_helper'
require "browet/group"

class Browet::GroupTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'categories_groups', json_string('groups')
    stub_get_request 'categories_groups/1', json_string('group1')
    stub_get_request 'categories_groups/2', json_string('group2')
    stub_get_request 'categories_groups/1/products', json_string('products')
    stub_get_request 'categories_groups/1/products/page/2/2', json_string('products_paged')
  end

  test "for valid list response" do
    groups = Browet::Group.list
    assert_kind_of Browet::ResultSet, groups

    group1 = groups[0]
    assert_instance_of Browet::Group, group1
    assert_equal 1, group1.id
    assert_equal 'group title 1', group1.title
    assert_equal 'group name 1', group1.name
    assert_kind_of Array, group1.categories
    assert_not_empty group1.categories

    group2 = groups[1]
    assert_instance_of Browet::Group, group2
    assert_equal 2, group2.id
    assert_equal 'group title 2', group2.title
    assert_equal 'group name 2', group2.name
    assert_kind_of Array, group2.categories
    assert_empty group2.categories
  end

  test "for valid get response" do
    group = Browet::Group.get(1)
    
    assert_kind_of Browet::Group, group
    assert_equal 1, group.id
    assert_equal 'group title 1', group.title
    assert_equal 'group name 1', group.name
    
    assert_kind_of Array, group.categories
    category1 = group.categories[0]
    assert_equal 1, category1.id
    assert_equal 'category title 1', category1.title
    assert_nil category1.parent_id
    assert_equal 1, category1.group_id
    assert_kind_of Array, category1.subcategories
    category3 = category1.subcategories[0]
    assert_equal 3, category3.id
    assert_equal 'category title 3', category3.title
    assert_equal 1, category3.parent_id
    assert_equal 1, category3.group_id

    category2 = group.categories[1]
    assert_equal 2, category2.id
    assert_equal 'category title 2', category2.title
    assert_nil category2.parent_id
    assert_equal 2, category2.group_id
    assert_kind_of Array, category2.subcategories
    assert_empty category2.subcategories
  end


  test "for valid products response" do
    group = Browet::Group.get(1)
    products = group.products
    product_list_tests(products)
  end

  test "for valid products paged response" do
    group = Browet::Group.get(1)
    products = group.products(2, 2)
    product_list_paged_tests(products)
  end

end
