require 'browet/repository'

module Browet

  ##
  # Base class for entities
  #
  class Entity
    
    # service attributes used to define some properties and behavior of children
    class << self; attr_reader :attributes, :repository, :list_root end

    ##
    # Constructs object by hash
    #
    def initialize(hash)
      # set object attribute vaues and create getters
      self.class.attributes.each do |attr|
        attr = attr.to_s
        self.instance_variable_set("@#{attr}", hash[attr])
        self.class.send(:define_method, attr, proc{self.instance_variable_get("@#{attr}")})
      end
    end
    
    ##
    # Returns Browet::ResultSet of all objects
    #
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

    ##
    # Returns object by given slug
    #
    def self.get(slug)
      entity = repository.get(slug)
      self.new(entity) unless entity.nil?
    end

    ##
    # Returns products property (Browet::ResultSet) of container object
    # 
    def products(page = nil, limit = nil)
      product_hash = self.class.repository.products(slug, page, limit)
      self.class.form_products(product_hash)
    end

    protected

      ##
      # Creates set (Browet::ResultSet) of products
      #
      def self.form_products(product_hash)
        unless product_hash.nil?
          Browet::ResultSet.new(
            product_hash['products'].map{ |x| Browet::Product.new(x) },
            product_hash['meta']['total_count'], 
            product_hash['meta']['pages'])
        else
          Browet::ResultSet.new
        end
      end

  end
end
