require "browet/entity"
require "browet/product_repository"

module Browet
  class Product < Browet::Entity

    @repository = Browet::ProductRepository
    @attributes = [:id, :description, :title, :guid, :mpn, :slug, 
      :availability, :gtin, :currency]

    def self.list(page = nil, limit = nil)
      products = repository.list(page, limit)
      products.map{ |x| self.new(x) } unless products.nil?
    end

    def self.find(params)
      products = repository.find(params)
      products.map{ |x| self.new(x) } unless products.nil?
    end

    # hide products method
    undef products

  end
end
