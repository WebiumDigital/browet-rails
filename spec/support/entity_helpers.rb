module EntityHelpers
  include WebMock::API

  # stub http request
  def stub_get_request(path, success_body = "", query_params = {}, success_headers = {})
    WebMock.stub_request(:get, Browet::Config.api_url + "/#{path}").
      with(:query => query_params.merge({"token" => Browet::Config.key})).
      to_return(:status => 200, :body => success_body, :headers => success_headers)
  end

  # read json form file
  def json_string(name)
    IO.read File.dirname(__FILE__) + "/../json/#{name}.json"
  end

  # init config and db access parameters
  def config_init(enable_cache = false)
    WebMock.reset!
    Browet::Config.account = 'account'
    Browet::Config.key = 'key'
    Browet::Config.enable_cache = enable_cache
    Browet::Cache.establish_connection(
      :adapter  => "postgresql",
      :host     => "localhost",
      :username => "browet",
      :password => "browet",
      :database => "browet"
    ) if enable_cache
  end

  # for invalid accounts tests
  def init_invalid_account
    WebMock.stub_request(:get, Browet::Config.api_url + "/categories_groups").
      with(:query => {"token" => Browet::Config.key}).
      to_return(:status => 401, :body => "", :headers => {})
  end

  # for server timeout tests
  def init_server_timeout
    WebMock.stub_request(:any, Browet::Config.api_url + "/products").
      with(:query => {"token" => Browet::Config.key}).
      to_timeout
  end

end
