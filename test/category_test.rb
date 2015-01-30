require 'test_helper'
require "browet/category"

class Browet::CategoryTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'categories/1', json_string('category1')
    stub_get_request 'categories/1/products/page/1/10', json_string('products')
    stub_get_request 'categories/1/products', json_string('products')
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

  test "for valid products paged response" do
    group = Browet::Category.get(1)
    products = group.products(1, 10)
    
    assert_kind_of Array, products
    assert_equal 2, products.length 

    product0 = products[0]
    assert_instance_of Browet::Product, product0
    assert_equal 1, product0.id
    assert_equal "product description 1", product0.description
    assert_equal "product title 1", product0.title
    assert_equal "guid 1", product0.guid
    assert_equal "mpn 1", product0.mpn
    assert_equal "slug 1", product0.slug
    assert product0.availability
    assert_equal "gtin 1", product0.gtin
    assert_equal "currency 1", product0.currency

    product1 = products[1]
    assert_instance_of Browet::Product, product1
    assert_equal 2, product1.id
    assert_equal "product description 2", product1.description
    assert_equal "product title 2", product1.title
    assert_equal "guid 2", product1.guid
    assert_equal "mpn 2", product1.mpn
    assert_equal "slug 2", product1.slug
    assert_not product1.availability
    assert_equal "gtin 2", product1.gtin
    assert_equal "currency 2", product1.currency
  end

  test "for valid products response" do
    group = Browet::Category.get(1)
    products = group.products
    
    assert_kind_of Array, products
    assert_equal 2, products.length 

    product0 = products[0]
    assert_instance_of Browet::Product, product0
    assert_equal 1, product0.id
    assert_equal "product description 1", product0.description
    assert_equal "product title 1", product0.title
    assert_equal "guid 1", product0.guid
    assert_equal "mpn 1", product0.mpn
    assert_equal "slug 1", product0.slug
    assert product0.availability
    assert_equal "gtin 1", product0.gtin
    assert_equal "currency 1", product0.currency

    product1 = products[1]
    assert_instance_of Browet::Product, product1
    assert_equal 2, product1.id
    assert_equal "product description 2", product1.description
    assert_equal "product title 2", product1.title
    assert_equal "guid 2", product1.guid
    assert_equal "mpn 2", product1.mpn
    assert_equal "slug 2", product1.slug
    assert_not product1.availability
    assert_equal "gtin 2", product1.gtin
    assert_equal "currency 2", product1.currency
  end

end
