require 'test/unit'
require 'app/marketplace/user'
require 'app/marketplace/item'

class ItemTest < Test::Unit::TestCase
  def test_name
    owner = Marketplace::User.named("Peter")
    item = Marketplace::Item.make("TestBox", 10, owner)
    assert(item.name == "TestBox", "Item isn't named properly.")
  end

  def test_price
    owner = Marketplace::User.named("Peter")
    item = Marketplace::Item.make("TestBox", 10, owner)
    assert(item.price == 10, "The price isn't set properly.")
  end

  def test_active
    owner = Marketplace::User.named("Peter")
    item = Marketplace::Item.make("TestBox", 10, owner)
    assert(!item.active, "Item should be inactive after creation.")
  end

  def test_owner
    owner = Marketplace::User.named("Peter")
    item = Marketplace::Item.make("TestBox", 10, owner)
    assert(item.owner == owner, "Owner not correct.")
  end
end