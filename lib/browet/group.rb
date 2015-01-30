require "browet/entity"
require "browet/category"
require "browet/group_repository"

module Browet
  class Group < Browet::Entity

    @repository = Browet::GroupRepository
    @attributes = [:id, :title, :name]
    @list_root = :categories_groups

    attr_accessor :categories

    def initialize(hash)
      super
      @categories = hash['categories'].map{ |x| Browet::Category.new(x) }
    end

  end
end
