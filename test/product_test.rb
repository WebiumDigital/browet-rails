require 'test_helper'
require "browet/product"

class Browet::ProductTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'products/1', json_string('product1')
    stub_get_request 'products/2', json_string('product2')
    stub_get_request 'products/3', json_string('product3')
    stub_get_request 'products', json_string('products')
    stub_get_request 'products/page/2/2', json_string('products_paged')
    stub_get_request 'products/search', json_string('products'), {title: 'product title 1'}
  end

  test "for valid products response" do
    assert_not_respond_to Browet::Product, :products
  end

  test "for valid get response" do
    product = Browet::Product.get(1)
    
    assert_kind_of Browet::Product, product
    assert_equal 1, product.id, 'Invalid product id'
    assert_equal "product description 1", product.description, 'Invalid product description'
    assert_equal "product title 1", product.title, 'Invalid product title'
    assert_equal "guid 1", product.guid, 'Invalid product guid'
    assert_equal "mpn 1", product.mpn, 'Invalid product mpn'
    assert_equal "slug 1", product.slug, 'Invalid product slug'
    assert product.availability, 'Invalid product availability'
    assert_equal "gtin 1", product.gtin, 'Invalid product gtin'
    assert_equal "currency 1", product.currency, 'Invalid product currency'
  end

  test "for valid list response" do
    products = Browet::Product.list
    product_list_tests(products, Browet::Product)
  end

  test "for valid list paged response" do
    products = Browet::Product.list(2, 2)
    product_list_paged_tests(products, Browet::Product)
  end

  test "for valid find response" do
    products = Browet::Product.find({title: 'product title 1'})
    product_list_tests(products, Browet::Product)
  end

end
