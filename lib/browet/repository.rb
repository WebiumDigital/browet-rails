module Browet
  class Repository

    def self.http_get(path, params = {})
      
      raise 'Empty account in config' if Browet::Config.account.blank?
      raise 'Empty key in config' if Browet::Config.key.blank?

      uri = URI("#{Browet::Config.api_url}/#{path}")
      uri.query = URI.encode_www_form(params.merge({token: Browet::Config.key}))

      res = Net::HTTP.get_response(uri)
      
      # res.is_a?(Net::HTTPSuccess) ? ActiveSupport::JSON.decode(res.body) : nil
      raise "Error #{res.code}" unless res.is_a?(Net::HTTPSuccess)
      ActiveSupport::JSON.decode(res.body)
    end

    protected

      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
