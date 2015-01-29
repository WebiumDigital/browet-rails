class EntityTestCase < ActiveSupport::TestCase

  protected

    def json_string(name)
      IO.read File.dirname(__FILE__) + "/json/#{name}.json"
    end

    def stub_get_request(path, success_body = "", success_headers = {})
      stub_request(:get, Browet::Config.api_url + "/#{path}").
        with(:query => {"token" => Browet::Config.key}).
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'account.browet.com', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => success_body, :headers => success_headers)

    end

end
