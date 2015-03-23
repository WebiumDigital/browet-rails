module Browet
  class CategoryRepository < Browet::Repository

    ##
    # Retuns hash of all categories set
    #
    def self.list
      http_get('categories')
    end

    ##
    # Retuns hash for category with given slug
    #
    def self.get(slug)
      http_get("categories/#{slug}")
    end

    ##
    # Retuns hash of product paged set for category with given slug
    #
    def self.products(slug, page, limit)
      http_get("categories/#{slug}/products#{page_suffix(page, limit)}")
    end

  end
end
