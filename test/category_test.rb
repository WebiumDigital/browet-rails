require 'test_helper'
require "browet/category"

class Browet::CategoryTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'categories/1', json_string('category1')
    stub_get_request 'categories/2', json_string('category2')
    stub_get_request 'categories/3', json_string('category3')
    stub_get_request 'categories/1/products', json_string('products')
    stub_get_request 'categories/1/products/page/2/2', json_string('products_paged')
  end

  test "for valid list response" do
    assert_not_respond_to Browet::Category, :list
  end

  test "for valid get response" do
    category = Browet::Category.get(1)
    
    assert_kind_of Browet::Category, category
    assert_equal 1, category.id
    assert_equal 'category title 1', category.title
    assert_nil category.parent_id
    assert_equal 1, category.group_id
    
    assert_kind_of Array, category.subcategories
    subcategory0 = category.subcategories[0]
    assert_equal 3, subcategory0.id
    assert_equal 'category title 3', subcategory0.title
    assert_equal 1, subcategory0.parent_id
    assert_equal 1, subcategory0.group_id
  end

  test "for valid products response" do
    group = Browet::Category.get(1)
    products = group.products
    product_list_tests(products)
  end

  test "for valid products paged response" do
    group = Browet::Category.get(1)
    products = group.products(2, 2)
    product_list_paged_tests(products)
  end

end
