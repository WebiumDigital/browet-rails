module Browet
  class Api < Her::API

  end
end

url = "http://#{Browet.options.client_domain}.#{Browet.options.browet_domain}/api/basic/v#{Browet.options.api_version}"
Browet::Api.setup url: url do |c|
  # Request
  c.use Browet::Authentication
  c.use Faraday::Request::UrlEncoded
  if Browet.options.cache.present?
    c.use FaradayMiddleware::Caching, Browet.options.cache
  end

  # Response
  c.use Her::Kaminari::HeaderParser
  c.use Her::Middleware::DefaultParseJSON


  # Adapter
  c.use Faraday::Adapter::NetHttp
end