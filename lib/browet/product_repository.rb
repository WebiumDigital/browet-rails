module Browet
  class ProductRepository < Browet::Repository

    ##
    # Retuns hash of all product set
    #
    def self.list(page, limit)
      http_get("products#{page_suffix(page, limit)}")
    end

    ##
    # Retuns hash for product with slug
    #
    def self.get_by_slug(slug)
      http_get("products/#{slug}")
    end

    ##
    # Retuns hash of found products
    #
    def self.find(search_params = {})
      http_get("products/search", search_params, true)
    end

  end
end
