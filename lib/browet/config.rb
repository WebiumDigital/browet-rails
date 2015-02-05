module Browet
  module Config
    extend self
    attr_accessor :version, :account, :key, :ttl

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
      @key ||= 28800
    end
  end
end
