require "browet/entity"
require "browet/product_repository"

module Browet
  class Product < Browet::Entity

    @repository = Browet::ProductRepository
    @attributes = [:id, :description, :title, :guid, :mpn, :slug, 
      :availability, :gtin, :currency]
    @list_root = :products

    def self.list(page = nil, limit = nil)
      products = repository.list(page, limit)
      form_products(products)
    end

    def self.find(params)
      products = repository.find(params)
      form_products(products)
    end

    # hide products method
    undef products

  end
end
