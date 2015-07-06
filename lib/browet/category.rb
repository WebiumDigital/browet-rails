module Browet
  class Category < Base
    attributes :id, :title, :parent_id, :category_group_id, :position, :slug

    belongs_to :category_group
    belongs_to :parent, :class_name=>'Category'
    has_many :categories, :class_name=>'Category'
    has_many :products, :class_name=>'Product'

    def self.find_by_slug slug
      get_raw("categories/by_slug/#{slug}") do |parsed_data, response|
        new_object_from_request.call(parsed_data, response)
      end
    end
  end
end