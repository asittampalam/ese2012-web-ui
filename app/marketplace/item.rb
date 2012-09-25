module Marketplace
  class Item
    attr_accessor :name, :price, :active, :owner


    def self.make(name, price, owner)
      item= self.new
      item.name= name
      item.price= price
      item.owner= owner

      item
    end


    def initialize
      self.active= false
    end
  end
end