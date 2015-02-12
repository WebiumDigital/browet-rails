require 'json'
require 'active_record'

module Browet

  class Cache < ::ActiveRecord::Base
    self.table_name = 'browet_cache'
    serialize :params, JSON

    def self.get(path, params = {}, useLocalizedToken)
      where('path=?', path).where('params=? AND locale=?', 
        params.to_json, Browet::Config.get_tokenized_locale).first
    end


  end

  class Repository

    def self.http_get(path, params = {})

      raise Browet::ConfigError, 'Empty account in config' if Browet::Config.account.empty?
      raise Browet::ConfigError, 'Empty default_token in config' if Browet::Config.default_token.empty?

      unless Browet::Config.enable_cache?
        
        # request servers
        JSON.parse(get_server_reply(path, params))

      else
        
        # check for cache record
        cached = Browet::Cache.get(path, params)

        if cached.nil? or (cached.updated_at < expired_time)
          begin
            json = get_server_reply(path, params)
            if cached.nil?
              cached = Browet::Cache.create!(path: path, params: params, 
                json: json, locale: Browet::Config.get_tokenized_locale)
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

      def self.get_server_reply(path, params)
          uri = URI("#{Browet::Config.api_url}/#{path}")
          locale = Browet::Config.get_tokenized_locale 
          token = locale.blank? ?
            Browet::Config.default_token :
            Browet::Config.localized_tokens[locale]
          uri.query = URI.encode_www_form(params.merge({token: token}))
          res = Net::HTTP.get_response(uri)
          raise Browet::HttpError, res.code unless res.is_a?(Net::HTTPSuccess)
          res.body
      end

      def self.expired_time
        # get DB time
        sql = "SELECT CURRENT_TIMESTAMP"
        db_time = Browet::Cache.connection.select_value(sql).to_time
        db_time - Browet::Config.ttl*3600
      end

      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
