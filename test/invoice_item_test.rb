require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceItemTest < MiniTest::Unit::TestCase
  
  attr_reader :ii, :se

  def setup
    se = SalesEngine.new
    se.startup
    data = {id: "1",
	    item_id: '2',
	    invoice_id: '1',
	    quantity: '5',
	    unit_price: '13635',
	    sales_engine_reference: se
  }

    @ii = InvoiceItem.new(data)
  end

  def test_it_exists
    assert_kind_of InvoiceItem, ii 
  end
  
  def test_id_is_set
    assert_equal "1", ii.id
  end

  def test_item_id_is_set
    assert_equal '2', ii.item_id
  end

  def test_invoice_id_is_set
    assert_equal '1', ii.invoice_id
  end

  def test_quantity_is_set
    assert_equal '5', ii.quantity
  end

  def test_unit_price_is_set
    assert_equal '13635', ii.unit_price
  end

  def test_method_invoice_exists
    assert ii.methods.include?(:invoice)
  end  

  def test_method_invoice_returns_invoice
    assert_kind_of Invoice, ii.invoice
  end

  def test_method_invoice_matches_invoice_id
    assert_equal ii.invoice_id, ii.invoice.id
  end

  def test_method_item_exists
    assert ii.methods.include?(:item)
  end  
  
  def test_item_returns_item
    assert_kind_of Item, ii.item
  end

  def test_method_item_matches_item_id
    assert_equal ii.item_id, ii.item.id
  end
end
