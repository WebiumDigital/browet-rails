require 'json'
require 'active_record'

module Browet

  ##
  # Cache for saving http requests and replies
  #
  class Cache < ::ActiveRecord::Base
    self.table_name = 'browet_cache'
    serialize :params, JSON

    ##
    # Returns cahced request
    #
    def self.get(path, params = {})
      where('path=?', path).where('params=? AND locale=?', 
        params.to_json, Browet::Config.get_tokenized_locale).first
    end
  end

  ##
  # Base class fore object repositories
  #
  class Repository

    ##
    # Returns hash recived after http request or from cahce
    #
    def self.http_get(path, params = {})

      # check config
      raise Browet::ConfigError, 'Empty account in config' if Browet::Config.account.empty?
      raise Browet::ConfigError, 'Empty default_token in config' if Browet::Config.default_token.empty?

      unless Browet::Config.enable_cache?

        # request servers if cache is disabled
        JSON.parse(get_server_reply(path, params))

      else
        
        # check for cached record
        cached = Browet::Cache.get(path, params)

        if cached.nil? or (cached.updated_at < expired_time)
          
          # send http request in case of empty or dirty cache
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

    ##
    # Stubs list method
    #
    def self.list(page, limit)
      raise "method self.list not implemented"
    end

    ##
    # Stubs get method (by slug or id)
    #
    def self.get(slug)
      raise "method self.get not implemented"
    end

    protected

      ##
      # Returns http reply body
      #
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

      ##
      # Caclulates cache expiration time
      #
      def self.expired_time
        # get DB time
        sql = "SELECT CURRENT_TIMESTAMP"
        db_time = Browet::Cache.connection.select_value(sql).to_time
        db_time - Browet::Config.ttl*3600
      end

      ##
      # Retuns path suffix for paged request
      #
      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
