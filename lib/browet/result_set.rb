module Browet
  class ResultSet
    attr_accessor :total_count, :pages

    include Enumerable
    extend Forwardable
    def_delegators :@set, :each, :[], :length

    def initialize(set = [], total_count = 0, pages = 0)
      @set = set
      @total_count = total_count
      @pages = pages
    end
  end
end
