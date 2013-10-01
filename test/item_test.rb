require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require 'pry'

class ItemTest < MiniTest::Unit::TestCase
  
  attr_reader :item, :se

  def setup
    @se = SalesEngine.new
    se.startup
    data = {id: '539',
	    name: "Rolen",
	    description: "Awesome",
	    unit_price: '100',
	    merchant_id: '10',
      sales_engine_reference: se
            #created_at: "date"
            #updated_at: "data
           }
    @item = Item.new(data)
  end

  def test_it_exists
    assert_kind_of Item, item
  end

  def test_id_is_set
    assert_equal '539', item.id
  end

  def test_name_is_set
    assert_equal "Rolen", item.name
  end

  def test_description_is_set
    assert_equal "Awesome", item.description
  end

  def test_unit_price_is_set
    assert_equal '100', item.unit_price
  end

  def test_merchant_id_is_set
    assert_equal '10', item.merchant_id
  end

  def test_invoice_items_method_exists
    assert item.methods.include?(:invoice_items)
  end

  def test_invoice_items_method_returns_array
    assert_kind_of Array, item.invoice_items
  end

  def test_invoice_items_method_not_empty
    refute item.invoice_items.empty?
  end

  def test_invoice_items_method_returns_invoice_items_associated_with_item
    item.invoice_items.each do |invoice_item|
      assert_equal item.id, invoice_item.item_id 
    end
  end

  def test_merchant_method_exists
    assert item.methods.include?(:merchant), "No merchant method defined"
  end

  def test_merchant_method_returns_a_merchant_type
    assert_kind_of Merchant, item.merchant 
  end

  def test_merchant_method_returns_merchant_associated_with_item
    assert_equal item.merchant_id, item.merchant.id
  end
end  
