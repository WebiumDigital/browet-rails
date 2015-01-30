require 'test_helper'
require "browet/product"

class Browet::ProductTest < EntityTestCase

  def initialize(a)
    super(a)
    stub_get_request 'products/1', json_string('product1')
    stub_get_request 'products/page/1/10', json_string('products')
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
    products = Browet::Product.list(1, 10)
    
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

  test "for valid find response" do
    products = Browet::Product.find({title: 'product title 1'})
    
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
  end

end
