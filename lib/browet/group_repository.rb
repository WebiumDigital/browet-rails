module Browet
  class GroupRepository < Browet::Repository

    def self.list
      http_get('categories_groups')
    end

    def self.get(id)
      http_get("categories_groups/#{id}")
    end

  end
end
