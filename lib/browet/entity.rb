require 'browet/repository'

module Browet
  class Entity
    class << self; attr_accessor :attributes, :repository end

    def initialize(hash)
      self.class.attributes.each do |attr|
        attr = attr.to_s
        self.instance_variable_set("@#{attr}", hash[attr])
        self.class.send(:define_method, attr, proc{self.instance_variable_get("@#{attr}")})
      end
    end
    
    def self.list
      entities = repository.list
      entities.map{ |x| self.new(x) } unless entities.nil?
    end

    def self.get(id)
      entity = repository.get(id)
      self.new(entity) unless entity.nil?
    end

    def products(page = nil, limit = nil)
      products = self.class.repository.products(id, page, limit)
      products.map{ |x| Browet::Product.new(x) } unless products.nil?      
    end

  end
end
