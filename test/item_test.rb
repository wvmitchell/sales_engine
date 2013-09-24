require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < MiniTest::Unit::TestCase
  
  attr_reader :item

  def setup
    data = {id: 1,
	    name: "Rolen",
	    description: "Awesome",
	    unit_price: 100,
	    merchant_id: 10
            #created_at: "date"
            #updated_at: "data
           }
    @item = Item.new(data)
  end

  def test_it_exists
    assert_kind_of Item, item
  end

  def test_id_is_set
    assert_equal 1, item.id
  end

  def test_name_is_set
    assert_equal "Rolen", item.name
  end

  def test_description_is_set
    assert_equal "Awesome", item.description
  end

  def test_unit_price_is_set
    assert_equal 100, item.unit_price
  end

  def test_merchant_id_is_set
    assert_equal 10, item.merchant_id
  end
end  
