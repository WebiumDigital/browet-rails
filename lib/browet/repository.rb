require 'json'
require 'active_record'

module Browet

  class Cache < ::ActiveRecord::Base
    self.table_name = 'browet_cache'
    serialize :params, JSON

    def self.get(path, params = {})
      where('path=?', path).where('params=?', params.to_json).first
    end
  end

  class Repository

    def self.http_get(path, params = {})

      raise Browet::ConfigError, 'Empty account in config' if Browet::Config.account.empty?
      raise Browet::ConfigError, 'Empty key in config' if Browet::Config.key.empty?

      unless Browet::Config.enable_cache?
        JSON.parse(get_reply(path, params))
      else
        # check for cache
        cached = Browet::Cache.get(path, params)

        if cached.nil? or (cached.updated_at < expired_time)
          
          begin
            json = get_reply(path, params)
            if cached.nil?
              cached = Browet::Cache.create!(path: path, params: params, json: json)
            else
              cached.update!(updated_at: Time.now)
            end
          rescue Timeout::Error => e
            raise e if cached.nil?
          end
        end
        JSON.parse(cached.json)
      end

    end

    protected

      def self.get_reply(path, params)
          uri = URI("#{Browet::Config.api_url}/#{path}")
          uri.query = URI.encode_www_form(params.merge({token: Browet::Config.key}))
          res = Net::HTTP.get_response(uri)
          raise Browet::HttpError, res.code unless res.is_a?(Net::HTTPSuccess)
          res.body
      end

      def self.expired_time
        #get DB time
        sql = "SELECT CURRENT_TIMESTAMP"
        db_time = Browet::Cache.connection.select_value(sql).to_time
        db_time - Browet::Config.ttl*3600
      end

      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
