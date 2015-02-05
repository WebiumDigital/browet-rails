require "browet/config"
require "browet/group"
require "browet/category"
require "browet/product"
require "browet/result_set"
require "browet/error"
require 'browet/railtie' if defined?(Rails)

module Browet

  extend self

  def self.init(&block)
    block.call(Config) if block_given?
  end

end
