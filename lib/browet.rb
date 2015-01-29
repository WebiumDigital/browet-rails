module Browet

  module Config
    extend self
    attr_accessor :version, :account, :key

    def api_url
      "http://#{account}.browet.com/api/#{version}"
    end

    # accessors with default values
    def version
      @version ||= 'v1'
    end
    def account
      @account ||= 'account'
    end
    def key
      @key ||= 'key'
    end
  end

  extend self

  def self.init(&block)
    block.call(Config) if block_given?
  end

end
