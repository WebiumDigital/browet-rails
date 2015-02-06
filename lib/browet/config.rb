module Browet
  module Config
    extend self
    attr_writer :version, :account, :key, :ttl, :enable_cache

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
    def key
      @key ||= ''
    end
    def ttl
      @ttl ||= 8
    end
    def enable_cache?
      @enable_cache ||= false
    end
  end
end
