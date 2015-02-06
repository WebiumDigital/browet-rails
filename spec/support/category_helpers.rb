module EntityHelpers

  def category_init
    config_init
    @stub_category1 = stub_get_request 'categories/1', json_string('category1')
    @stub_category2 = stub_get_request 'categories/2', json_string('category2')
    @stub_category3 = stub_get_request 'categories/3', json_string('category3')
    @stub_category_products = stub_get_request 'categories/1/products', json_string('products')
    @stub_category_products_paged = stub_get_request 'categories/1/products/page/2/2', json_string('products_paged')
  end

  def should_be_category_1(category)
    expect(category).to be_a(Browet::Category)
    expect(category.id).to eq(1)
    expect(category.title).to eq('category title 1')
    expect(category.parent_id).to be_nil
    expect(category.group_id).to eq(1)
    expect(category.subcategories).to be_a(Array)
    expect(category.subcategories).not_to be_empty

    subcategory = category.subcategories[0]
    expect(subcategory).to be_a(Browet::Category)
    expect(subcategory.id).to eq(3)
    expect(subcategory.title).to eq('category title 3')
    expect(subcategory.parent_id).to eq(1)
    expect(subcategory.group_id).to eq(1)
    expect(subcategory.subcategories).to be_a(Array)
    expect(subcategory.subcategories).to be_empty
  end

  def should_be_category_2(category)
    expect(category).to be_a(Browet::Category)
    expect(category.id).to eq(2)
    expect(category.title).to eq('category title 2')
    expect(category.parent_id).to be_nil
    expect(category.group_id).to eq(2)
    expect(category.subcategories).to be_a(Array)
    expect(category.subcategories).to be_empty
  end

  def should_be_category_3(category)
    expect(category).to be_a(Browet::Category)
    expect(category.id).to eq(3)
    expect(category.title).to eq('category title 3')
    expect(category.parent_id).to eq(1)
    expect(category.group_id).to eq(1)
    expect(category.subcategories).to be_a(Array)
    expect(category.subcategories).to be_empty
  end

end
