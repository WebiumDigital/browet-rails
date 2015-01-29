module Browet
  module Repository
    extend self

    def get(path)
      uri = URI("#{Browet::Config.api_url}/#{path}")
      uri.query = URI.encode_www_form({token: Browet::Config.key})

      res = Net::HTTP.get_response(uri)
      res.is_a?(Net::HTTPSuccess) ? ActiveSupport::JSON.decode(res.body) : nil
    end

  end
end
