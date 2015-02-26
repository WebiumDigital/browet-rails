require 'json'
require 'active_record'
require "browet/cache"

module Browet

  ##
  # Base class fore object repositories
  #
  class Repository

    ##
    # Returns hash recived after http request or from cahce
    #
    def self.http_get(path, params = {}, disable_cahce = false)

      # check config
      raise Browet::ConfigError, 'Empty account in config' if Browet::Config.account.empty?
      raise Browet::ConfigError, 'Empty default_token in config' if Browet::Config.default_token.empty?

      if !Browet::Config.enable_cache? or disable_cahce or (Browet::Config.ttl == 0)

        # request servers withowt cahce updating
        JSON.parse(get_server_reply(path, params))

      else
        
        # check for nondirty cached record
        cached = Browet::Cache.get(path, params)

        if cached.nil?
          
          begin
            # send http request in case of empty or dirty cache
            json = get_server_reply(path, params)
            cached = Browet::Cache.set(path, params, json)
          rescue Timeout::Error => e
            # try to get dirty record
            cached = Browet::Cache.get(path, params, true)
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
    def self.get(id)
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
      # Retuns path suffix for paged request
      #
      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
