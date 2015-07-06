module Browet
  class Authentication < Faraday::Middleware
    def call(env)
      env[:request_headers]["X-Auth-Token"] = Browet.options.client_token
      @app.call(env)
    end
  end
end