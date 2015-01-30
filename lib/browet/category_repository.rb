module Browet
  class CategoryRepository < Browet::Repository

    def self.list
      http_get('categories')
    end

    def self.get(id)
      http_get("categories/#{id}")
    end

    def self.products(id, page, limit)
      http_get("categories/#{id}/products#{page_suffix(page, limit)}")
    end

  end
end
