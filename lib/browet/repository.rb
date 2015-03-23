require 'json'
require 'browet/requester'
require "browet/cache"

module Browet

  class Repository

    ##
    # Returns hash recived after http request or from cahce
    #
    def self.http_get(path, search_query = '', disable_cahce = false)

      # check config
      raise ConfigError, 'Empty account in config' if Config.account.empty?
      raise ConfigError, 'Empty default_token in config' if Config.default_token.empty?

      if !Config.enable_cache? or disable_cahce or (Config.ttl == 0)

        # request servers withowt cahce updating
        JSON.parse(Requester.perform_now(path, search_query, false))

      else

        # check for nondirty cached record
        cached = Cache.get(path, search_query)

        if cached.nil?  # there is no nondirty record

          # try to get dirty record
          cached = Cache.get(path, search_query, true)

          if cached.nil?  # there is no cached records
            # make request and update cahce
            cached = Requester.perform_now(path, search_query)
          else
            # make background cahce update
            Requester.perform_later(path, search_query)
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
    # Stubs get method
    #
    def self.get(id)
      raise "method self.get not implemented"
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
