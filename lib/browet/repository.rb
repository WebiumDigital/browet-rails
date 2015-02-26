require 'json'
require 'active_record'
require 'active_job'
require "browet/cache"

module Browet

  ##
  # Class fore backgroud cache update job
  #
  class BackgroundCacheUpdater < ActiveJob::Base
    def perform(path, params)
      json = Repository::get_server_reply(path, params)
      cached = Cache.set(path, params, json)
    end
  end

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

        if cached.nil?  # there is no nondirty record
          
          # try to get dirty record
          cached = Browet::Cache.get(path, params, true)
          
          if cached.nil?  # there is no dirty record
            # make request and update cahce
            json = get_server_reply(path, params)
            cached = Cache.set(path, params, json)
          else
            # make background cahce update
            # json = get_server_reply(path, params)
            # cached = Cache.set(path, params, json)
            BackgroundCacheUpdater.perform_later(path, params)
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

    protected

      ##
      # Retuns path suffix for paged request
      #
      def self.page_suffix(page, limit)
        (!page.nil? and !limit.nil?) ? "/page/#{page}/#{limit}" : ''
      end

  end
end
