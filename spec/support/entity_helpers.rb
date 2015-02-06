module EntityHelpers
  include WebMock::API

  def stub_get_request(path, success_body = "", query_params = {}, success_headers = {})
    WebMock.stub_request(:get, Browet::Config.api_url + "/#{path}").
      with(:query => query_params.merge({"token" => Browet::Config.key})).
      # with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'account.browet.com', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => success_body, :headers => success_headers)
  end

  def json_string(name)
    IO.read File.dirname(__FILE__) + "/../json/#{name}.json"
  end

  def should_request(path, query_params = {})
    expect(
      WebMock.a_request(:get, Browet::Config.api_url + "/#{path}").
      with(:query => query_params.merge({"token" => Browet::Config.key}))
    ).to have_been_made.times(3)
    # expect(WebMock).to have_requested(:get, Browet::Config.api_url + "/#{path}").
    #   with(:query => query_params.merge({"token" => Browet::Config.key}))
  end

  def should_not_request(path, query_params = {})
    expect(WebMock).not_to have_requested(:get, Browet::Config.api_url + "/#{path}").
      with(:query => query_params.merge({"token" => Browet::Config.key}))
  end

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

  def init_invalid_account
    WebMock.stub_request(:get, Browet::Config.api_url + "/categories_groups").
      with(:query => {"token" => Browet::Config.key}).
      to_return(:status => 401, :body => "", :headers => {})
  end

  def init_server_timeout
    WebMock.stub_request(:any, Browet::Config.api_url + "/products").
      with(:query => {"token" => Browet::Config.key}).
      to_timeout
  end

end
