require "browet/group"
require "browet/config"
require "browet/repositoty"

module Browet

  extend self

  def self.init(&block)
    block.call(Config) if block_given?
  end

end
