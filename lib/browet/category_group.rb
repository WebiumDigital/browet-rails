module Browet
  class CategoryGroup < Base
    attributes :id, :name, :title, :slug

    has_many :categories, :class_name=>'Category'
    has_many :products, :class_name=>'Product'

    def self.find_by_slug slug
      get_raw("category_groups/by_slug/#{slug}") do |parsed_data, response|
        new_object_from_request.call(parsed_data, response)
      end
    end
  end
end