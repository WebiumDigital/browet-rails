module Browet
  
  ## 
  # Gem config with defaults
  #
  module Config
    extend self
    attr_writer :version, :account, :key, :ttl, :enable_cache,
      :localized_tokens, :default_token,  
      :product_search_autocomplete_url, :product_search_autocomplete_length

    # number of seconds in the ttl unit
    TTL_MULTIPLICATOR = 60

    def api_url
      "http://#{account}.browet.com/api/#{version}"
    end

    # accessors with default values
    def version
      @version ||= 'v1'
    end
    def account
      @account ||= ''
    end
    def localized_tokens
      @localized_tokens ||= {}
    end
    def default_token
      @default_token ||= ''
    end
    def ttl
      @ttl ||= 10
    end
    def enable_cache?
      @enable_cache ||= false
    end
    
    def widgets_root_url
      @widgets_root_url ||= 'browet'
    end
    def product_search_autocomplete_url
      @product_search_autocomplete_url ||= 'product_search_autocomplete'
    end
    def product_search_autocomplete_length
      @product_search_autocomplete_length ||= 3
    end

    def get_tokenized_locale
      localized_tokens[I18n.locale].blank? ? '' : I18n.locale
    end
    def get_localized_token
      localized_tokens[I18n.locale].blank? ? default_token : localized_tokens[I18n.locale]
    end

  end
end
