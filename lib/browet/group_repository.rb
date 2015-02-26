module Browet
  class GroupRepository < Browet::Repository

    ##
    # Retuns hash of all groups set
    #
    def self.list
      http_get('categories_groups')
    end

    ##
    # Retuns hash for group with slug or id
    #
    def self.get(id)
      http_get("categories_groups/#{id}")
    end

    ##
    # Retuns hash of product paged set for group with slug or id
    #
    def self.products(id, page, limit)
      http_get("categories_groups/#{id}/products#{page_suffix(page, limit)}")
    end

  end
end
