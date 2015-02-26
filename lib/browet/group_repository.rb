module Browet
  class GroupRepository < Browet::Repository

    ##
    # Retuns hash of all groups set
    #
    def self.list
      http_get('categories_groups')
    end

    ##
    # Retuns hash for group with slug
    #
    def self.get_by_slug(slug)
      http_get("categories_groups/#{slug}")
    end

    ##
    # Retuns hash of product paged set for group with slug
    #
    def self.products(slug, page, limit)
      http_get("categories_groups/#{slug}/products#{page_suffix(page, limit)}")
    end

  end
end
