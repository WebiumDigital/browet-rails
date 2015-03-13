module Browet
  class ProductRepository < Browet::Repository

    ##
    # Retuns hash of all product set
    #
    def self.list(page, limit)
      http_get("products#{page_suffix(page, limit)}")
    end

    ##
    # Retuns hash for product with slug or id
    #
    def self.get(id)
      http_get("products/#{id}")
    end

    ##
    # Retuns hash of found products
    #
    def self.find(search_params = {})
      http_get("products/search", search_params, true)
    end

  end
end
