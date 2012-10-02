module Marketplace
  class Item
    attr_accessor :name, :price, :active, :owner

    #creates an item. Name must be a string, price must be a positive number and owner must be a user
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