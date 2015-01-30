module Browet
  class Repository

    def self.http_get(path, params = {})
      uri = URI("#{Browet::Config.api_url}/#{path}")
      uri.query = URI.encode_www_form(params.merge({token: Browet::Config.key}))

      res = Net::HTTP.get_response(uri)
      res.is_a?(Net::HTTPSuccess) ? ActiveSupport::JSON.decode(res.body) : nil
    end

    protected

      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
