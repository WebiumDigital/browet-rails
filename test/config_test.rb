require 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  
  def initialize(a)
    super a
    Browet::Config.account = 'account'
    Browet::Config.key = 'key'
  end

  test "initializer default version" do
    assert_equal 'v1', Browet::Config.version 
  end

  test "initializer default api_url" do
    assert_equal 'http://account.browet.com/api/v1', Browet::Config.api_url 
  end

end