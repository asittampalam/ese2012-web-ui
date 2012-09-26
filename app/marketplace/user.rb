module Marketplace
  class User
    attr_accessor :name, :credit, :items

    def initialize
      self.items= Array.new
      self.credit= 100
    end

    #creates a user with the given name. Name must be a string.
    def self.named(name)
      user= self.new
      user.name= name
      user
    end

    #creates an item. Name must be a string and price has to be a positive number.
    def createItem(name, price)
      item=Item.make(name, price, self)
      items.push(item)
      item
    end

    def getAvailableItems
       items.select { |item| item.isActive}
    end

    #Makes the user buy the given item. If the item isn't active - it simply isn't bought.
    #Also the item should be in the list of another user (I haven't coded anything to ensure this, so it might work - or it might not.
    #Depends on the credits the user has. But buying an object from yourself certainly makes no sence, so I simply forbid it by contract..)
    def buy(item)
       if item.active && credit >= item.price
         item.owner.sell(item)
         item.active=false
         item.owner= self
         items.push(item)
         self.credit=credit-item.price
       end
    end

    #Lets the user sell the given item. The item has to be an active item in the list of the user instance.
    def sell(item)
      items.delete_if{|i| i==item}
      self.credit=credit+item.price
    end

  end
end
