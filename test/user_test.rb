require 'test/unit'
require 'app/marketplace/user'
require 'app/marketplace/item'

class ItemTest < Test::Unit::TestCase
  def test_name
    user = Marketplace::User.named("Peter")
    assert(user.name == "Peter", "User isn't named properly.")
  end

  def test_credit
    user = Marketplace::User.named("Peter")
    assert(user.credit==100, "User should have a credit amount of 100 after creation.")
  end

  def test_item_creation
    user = Marketplace::User.named("Peter")
    item= user.createItem("TestBox", 10)
    assert(!user.items.select{|i| i==item}.empty?, "Item wasn't created successfully.")
  end

  def test_active_item_listing
    user = Marketplace::User.named("Peter")
    item1= user.createItem("TestBox1", 10)
    item2= user.createItem("TestBox2", 10)
    item3= user.createItem("TestBox3", 10)

    item1.active=true
    item3.active=true

    assert(user.items.count{|item| item.active} == 2, "Active item listing isn't correct.")
  end

  def test_successful_trade
    peter = Marketplace::User.named("Peter")
    anna = Marketplace::User.named("Anna")
    item= peter.createItem("Testbox", 10)
    item.active=true

    anna.buy(item)

    assert(!anna.items.select{|i| item==i}.empty?, "Anna's list hasn't got the bought item.")
    assert(peter.items.select{|i| item==i}.empty?, "Peter shouldn't have any items anymore.")
    assert(anna.credit==90, "Anna's credit amount should be 90.")
    assert(peter.credit=110, "Peter's credit amount should be 110.")
    assert(!item.active, "Item should be inactive after trade.")
    assert(item.owner==anna, "Anna should own the item now.")
  end

  def test_not_enough_credit
    peter = Marketplace::User.named("Peter")
    anna = Marketplace::User.named("Anna")
    item= peter.createItem("Testbox", 110)
    item.active=true

    anna.buy(item)

    assert(anna.items.select{|i| item==i}.empty?, "Anna's list shouldn't contain the item.")
  end

  def test_shouldnt_buy_inactive_item
    peter = Marketplace::User.named("Peter")
    anna = Marketplace::User.named("Anna")
    item= peter.createItem("Testbox", 10)

    anna.buy(item)

    assert(anna.items.select{|i| item==i}.empty?, "Anna's list shouldn't contain the item.")
  end

end