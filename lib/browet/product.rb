module Browet
  class Product < Base
    include Her::Kaminari::Collection

    has_many :pictures, :class_name=>'Picture'
    belongs_to :brand, :class_name=>'Brand'
    has_many :properties, :class_name=>'ProductProperty'
    has_one :cover, :class_name=>'Picture'

    def self.find_by_slug slug
      get_raw("products/by_slug/#{slug}") do |parsed_data, response|
        new_object_from_request.call(parsed_data, response)
      end
    end

    scope :search, ->(query) {
      self.where(query: query)
    }

    def categories
      category_ids.map{|ci| Browet::Category.find(ci)}
    end
  end
end