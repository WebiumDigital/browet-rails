module Browet
  class ProductRepository < Browet::Repository

    def self.list(page, limit)
      http_get("products#{page_suffix(page, limit)}")
    end

    def self.get(id)
      http_get("products/#{id}")
    end

    def self.find(search_params = {})
      http_get("products/search", search_params)
    end

  end
end
