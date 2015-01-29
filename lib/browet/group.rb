# require 'browet/repositoty'

module Browet
  class Group
    @@attrs = [:id, :title, :name]

    def initialize(hash)
      @@attrs.each do |attr|
        attr = attr.to_s
        self.instance_variable_set("@#{attr}", hash[attr])
        self.class.send(:define_method, attr, proc{self.instance_variable_get("@#{attr}")})
      end
    end

    def self.list
      groups = Browet::Repository.get('categories_groups')
      groups.map{ |x| self.new(x) } unless groups.nil?
    end

    def self.get(id)
      group = Browet::Repository.get("categories_groups/#{id}")
      self.new(group) unless group.nil?
    end

  end
end
