require "browet/entity"
require "browet/category"
require "browet/group_repository"

module Browet
  class Group < Browet::Entity

    @repository = Browet::GroupRepository
    @list_root = :categories_groups

    # availabel attributes
    @attributes = [:id, :title, :name, :slug]
    attr_reader :categories

    def initialize(hash)
      super
      @categories = hash['categories'].map{ |x| Browet::Category.new(x) }
    end

  end
end
