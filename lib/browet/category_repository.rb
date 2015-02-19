module Browet
  class CategoryRepository < Browet::Repository

    ##
    # Retuns hash of all categories set
    #
    def self.list
      http_get('categories')
    end

    ##
    # Retuns hash for category with id
    #
    def self.get(id)
      http_get("categories/#{id}")
    end

    ##
    # Retuns hash of product paged set for category with id
    #
    def self.products(id, page, limit)
      http_get("categories/#{id}/products#{page_suffix(page, limit)}")
    end

  end
end
