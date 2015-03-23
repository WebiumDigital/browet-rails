module Browet

  ##
  # Gem config with defaults
  #
  module Config
    extend self

    attr_writer :protocol, :name_server, :version_api, :account, :key, :ttl, 
      :enable_cache, :localized_tokens, :default_token

    # Number of seconds in the ttl unit
    TTL_MULTIPLICATOR = 60

    def api_url
      "#{protocol}://#{account}.#{name_server}/api/#{version_api}"
    end


    # Accessors with default values
    def protocol
      @protocol ||= 'http'
    end

    def name_server
      @name_server ||= 'browet.com'
    end

    def version_api
      @version_api ||= 'v1'
    end

    def account
      @account ||= 'demo'
    end

    def localized_tokens
      @localized_tokens ||= {}
    end

    def default_token
      @default_token ||= 'kkJhdsj39sdlkjf93JKFHS93dkkhfd9Fhj'
    end

    def ttl
      @ttl ||= 10
    end

    def enable_cache?
      @enable_cache ||= false
    end
    
    def get_tokenized_locale
      localized_tokens[I18n.locale].blank? ? '' : I18n.locale
    end

    def get_localized_token
      localized_tokens[I18n.locale].blank? ? default_token : localized_tokens[I18n.locale]
    end

  end
end
