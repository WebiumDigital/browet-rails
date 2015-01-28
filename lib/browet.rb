module Browet

  module Config
    extend self
    attr_accessor :url, :account, :key
  end

  extend self

  def self.init(&block)
    if block_given?
      block.call(Config)
    else
      require 'browet/initialaizer'
    end
  end

end
