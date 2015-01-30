module Browet
  class CategoryRepository < Browet::Repository

    def self.list
      http_get('categories')
    end

    def self.get(id)
      http_get("categories/#{id}")
    end

  end
end
