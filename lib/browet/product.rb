require "browet/entity"
require "browet/product_repository"

module Browet
  class Product < Browet::Entity

    @repository = Browet::ProductRepository
    @list_root = :products

    # availabel attributes
    @attributes = [:id, :description, :title, :guid, :mpn, :slug, 
      :availability, :gtin, :currency]

    ##
    # Returns paged set (Browet::ResultSet) of products
    #
    def self.list(page = nil, limit = nil)
      products = repository.list(page, limit)
      form_products(products)
    end

    ##
    # Returns set (Browet::ResultSet) of products found by given search_query
    #
    def self.find(search_query)
      products = repository.find(search_query)
      form_products(products)
    end

    # hide products method
    undef products

  end
end
