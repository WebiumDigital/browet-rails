require 'test_helper'
require "browet/category"

class Browet::CategoryTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'categories/1', json_string('category1')
  end

  test "for valid list response" do
    assert_not_respond_to Browet::Category, :list
  end

  test "for valid get response" do
    category = Browet::Category.get(1)
    
    assert_kind_of Browet::Category, category
    assert_equal 1, category.id, 'Invalid category id'
    assert_equal 'root_categories title 1', category.title, 'Invalid category title'
    assert_nil category.parent_id, 'Invalid parent_id name'
    assert_equal 1, category.group_id, 'Invalid category group id'
    assert_kind_of Array, category.subcategories
    subcategory0 = category.subcategories[0]
    assert_equal 3, subcategory0.id, 'Invalid category id'
    assert_equal 'root_categories title 3', subcategory0.title, 'Invalid category title'
    assert_equal 1, subcategory0.parent_id, 'Invalid category parent_id name'
    assert_equal 1, subcategory0.group_id, 'Invalid category group id'
  end

end
