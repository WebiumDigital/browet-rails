require 'json'
require 'active_record'

module Browet

  class Cache < ::ActiveRecord::Base
    self.table_name = 'browet_cache'
    serialize :params
  end

  class Repository

    def self.http_get(path, params = {})
      
      raise Browet::ConfigError, 'Empty account in config' if Browet::Config.account.empty?
      raise Browet::ConfigError, 'Empty key in config' if Browet::Config.key.empty?

      uri = URI("#{Browet::Config.api_url}/#{path}")
      uri.query = URI.encode_www_form(params.merge({token: Browet::Config.key}))

      res = Net::HTTP.get_response(uri)
      
      # res.is_a?(Net::HTTPSuccess) ? ActiveSupport::JSON.decode(res.body) : nil
      raise Browet::HttpError, res.code unless res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    end

    protected

      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
