require 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  test "initializer default version" do
    assert_equal 'v1', Browet::Config.version 
  end

  test "initializer default account" do
    assert_equal 'account', Browet::Config.account 
  end

  test "initializer default key" do
    assert_equal 'key', Browet::Config.key 
  end

  test "initializer default api_url" do
    assert_equal 'http://account.browet.com/api/v1', Browet::Config.api_url 
  end

end