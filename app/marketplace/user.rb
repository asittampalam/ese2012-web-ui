module Marketplace
  class User
    attr_accessor :name, :credit, :items

    def initialize
      self.items= Array.new
      self.credit= 100
    end

    def self.named(name)
      user= self.new
      user.name= name
      user
    end

    def createItem(name, price)
      item=Item.make(name, price, self)
      items.push(item)
      item
    end

    def getAvailableItems
       items.select { |item| item.isActive}
    end


    def buy(item)
       if item.active && credit >= item.price
         item.owner.sell(item)
         item.active=false
         items.push(item)
         self.credit=credit-item.price
       end
    end

    def sell(item)
      items.delete_if{|i| i==item}
      self.credit=credit+item.price
    end

  end
end
