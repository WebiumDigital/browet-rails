require 'test_helper'
 
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
  end

  test "for valid get response" do
    group = Browet::Group.get(1)
    assert_kind_of Browet::Group, group
    assert_equal 1, group.id, 'Invalid group id'
    assert_equal 'group title 1', group.title, 'Invalid group title'
    assert_equal 'group name 1', group.name, 'Invalid group name'
  end

end
