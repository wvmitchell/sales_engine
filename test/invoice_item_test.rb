require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < MiniTest::Unit::TestCase
  
  attr_reader :ii

  def setup
    data = {id: 1,
	    item_id: 12,
	    invoice_id: 13,
	    quantity: 44,
	    unit_price: 100
    }
    @ii = InvoiceItem.new(data)
  end

  def test_it_exists
    assert_kind_of InvoiceItem, ii 
  end
  
  def test_id_is_set
    assert_equal 1, ii.id
  end

  def test_item_id_is_set
    assert_equal 12, ii.item_id
  end

  def test_invoice_id_is_set
    assert_equal 13, ii.invoice_id
  end

  def test_quantity_is_set
    assert_equal 44, ii.quantity
  end

  def test_unit_price_is_set
    assert_equal 100, ii.unit_price
  end
end
