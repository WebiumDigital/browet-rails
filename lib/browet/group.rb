require "browet/entity"
require "browet/category"
require "browet/group_repository"

module Browet
  class Group < Browet::Entity

    @repository = Browet::GroupRepository
    @attributes = [:id, :title, :name]

    attr_accessor :categories

    def initialize(hash)
      super
      @categories = hash['root_categories'].map{ |x| Browet::Category.new(x) }
    end

  end
end
