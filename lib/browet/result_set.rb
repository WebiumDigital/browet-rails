module Browet

  ##
  # Set of objects with meta-data.
  #
  class ResultSet
    include Enumerable
    extend Forwardable

    # meta-data
    attr_reader :total_count, :pages

    # array methods
    def_delegators :@set, :each, :[], :length

    def initialize(set = [], total_count = 0, pages = 0)
      @set = set
      @total_count = total_count
      @pages = pages
    end
  end
end
