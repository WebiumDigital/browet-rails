module EntityHelpers

  def group_init
    config_init
    stub_get_request 'categories_groups', json_string('groups')
    stub_get_request 'categories_groups/1', json_string('group1')
    stub_get_request 'categories_groups/2', json_string('group2')
    stub_get_request 'categories_groups/1/products', json_string('products')
    stub_get_request 'categories_groups/1/products/page/2/2', json_string('products_paged')
  end

  def should_be_group_1(group)
    expect(group).to be_a(Browet::Group)
    expect(group.id).to eq(1)
    expect(group.title).to eq('group title 1')
    expect(group.name).to eq('group name 1')
    expect(group.categories).to be_a(Array)
    expect(group.categories).not_to be_empty
    
    category1 = group.categories[0]
    expect(category1).to be_a(Browet::Category)
    expect(category1.id).to eq(1)
    expect(category1.title).to eq('category title 1')
    expect(category1.parent_id).to be_nil
    expect(category1.group_id).to eq(1)
    expect(category1.subcategories).to be_a(Array)
    expect(category1.subcategories).not_to be_empty

    category3 = category1.subcategories[0]
    expect(category3).to be_a(Browet::Category)
    expect(category3.id).to eq(3)
    expect(category3.title).to eq('category title 3')
    expect(category3.parent_id).to eq(1)
    expect(category3.group_id).to eq(1)
    expect(category3.subcategories).to be_a(Array)
    expect(category3.subcategories).to be_empty

    category2 = group.categories[1]
    expect(category2).to be_a(Browet::Category)
    expect(category2.id).to eq(2)
    expect(category2.title).to eq('category title 2')
    expect(category2.parent_id).to be_nil
    expect(category2.group_id).to eq(2)
    expect(category2.subcategories).to be_a(Array)
    expect(category2.subcategories).to be_empty
  end

  def should_be_group_2(group)
    expect(group).to be_a(Browet::Group)
    expect(group.id).to eq(2)
    expect(group.title).to eq('group title 2')
    expect(group.name).to eq('group name 2')
    expect(group.categories).to be_a(Array)
    expect(group.categories).to be_empty
  end

end
