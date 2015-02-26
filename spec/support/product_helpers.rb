module EntityHelpers

  def product_init
    @stub_product1 = stub_get_request 'products/product1', json_string('product1')
    @stub_product2 = stub_get_request 'products/product2', json_string('product2')
    @stub_product3 = stub_get_request 'products/product3', json_string('product3')
    @stub_products = stub_get_request 'products', json_string('products')
    @stub_product_paged = stub_get_request 'products/page/2/2', json_string('products_paged')
    @stub_product_fined = stub_get_request 'products/search', json_string('products_find'), {title: 'product title 1'}
  end

  def should_be_product_1(product)
    expect(product).to be_a(Browet::Product)
    expect(product.id).to eq(1)
    expect(product.title).to eq('product title 1')
    expect(product.description).to eq('product description 1')
    expect(product.guid).to eq('guid 1')
    expect(product.mpn).to eq('mpn 1')
    expect(product.slug).to eq('product1')
    expect(product.availability).to eq('availability 1')
    expect(product.gtin).to eq('gtin 1')
    expect(product.currency).to eq('currency 1')
  end

  def should_be_product_2(product)
    expect(product).to be_a(Browet::Product)
    expect(product.id).to eq(2)
    expect(product.title).to eq('product title 2')
    expect(product.description).to eq('product description 2')
    expect(product.guid).to eq('guid 2')
    expect(product.mpn).to eq('mpn 2')
    expect(product.slug).to eq('product2')
    expect(product.availability).to eq('availability 2')
    expect(product.gtin).to eq('gtin 2')
    expect(product.currency).to eq('currency 2')
  end

  def should_be_product_3(product)
    expect(product).to be_a(Browet::Product)
    expect(product.id).to eq(3)
    expect(product.title).to eq('product title 3')
    expect(product.description).to eq('product description 3')
    expect(product.guid).to eq('guid 3')
    expect(product.mpn).to eq('mpn 3')
    expect(product.slug).to eq('product3')
    expect(product.availability).to eq('availability 3')
    expect(product.gtin).to eq('gtin 3')
    expect(product.currency).to eq('currency 3')
  end

  def should_be_unpaged_set(products)
    expect(products.total_count).to eq(3)
    expect(products.pages).to eq(1)
    expect(products.length).to eq(3)
    should_be_product_1 products[0]
    should_be_product_2 products[1]
    should_be_product_3 products[2]
  end

  def should_be_paged_set(products)
    expect(products.total_count).to eq(3)
    expect(products.pages).to eq(2)
    expect(products.length).to eq(1)
    should_be_product_3 products[0]
  end

  def should_be_find_set(products)
    expect(products.total_count).to eq(1)
    expect(products.pages).to eq(1)
    expect(products.length).to eq(1)
    should_be_product_1 products[0]
  end

end
