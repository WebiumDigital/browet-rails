require 'browet/repository'

module Browet
  class Entity
    
    class << self; attr_accessor :attributes, :repository, :list_root end

    def initialize(hash)
      self.class.attributes.each do |attr|
        attr = attr.to_s
        self.instance_variable_set("@#{attr}", hash[attr])
        self.class.send(:define_method, attr, proc{self.instance_variable_get("@#{attr}")})
      end
    end
    
    def self.list
      entities = repository.list
      unless entities.nil?
        Browet::ResultSet.new(
          entities[list_root.to_s].map{ |x| self.new(x) }, 
          entities[list_root.to_s].length, 1)
      else
        Browet::ResultSet.new
      end
    end

    def self.get(id)
      entity = repository.get(id)
      self.new(entity) unless entity.nil?
    end

    def products(page = nil, limit = nil)
      products = self.class.repository.products(id, page, limit)
      self.class.form_products(products)
    end

    protected

      def self.form_products(products)
        unless products.nil?
          Browet::ResultSet.new(
            products['products'].map{ |x| Browet::Product.new(x) },
            products['meta']['total_count'], products['meta']['pages'])
        else
          Browet::ResultSet.new
        end
      end

  end
end
