require "browet/entity"
require "browet/category_repository"

module Browet
  class Category < Browet::Entity
    
    @repository = Browet::CategoryRepository
    @attributes = [:id, :title, :parent_id, :group_id]

    attr_accessor :subcategories

    def initialize(hash)
      super
      @subcategories = hash['subcategories'].map{ |x| Browet::Category.new(x) }
    end

    # hide listmethod
    class << self; undef list end

  end
end
