require "browet/config"

module Browet

  extend self

  def self.init(&block)
    block.call(Config) if block_given?
  end

end
