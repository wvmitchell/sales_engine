require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Unit::TestCase

  attr_reader :inv

  def setup
    data =  { id: 1,
    customer_id: 21,
    merchant_id: 26,
    status: 'shipped', 
    }
    @inv = Invoice.new(data)
  end

  def test_it_exists
    assert_kind_of Invoice, inv
  end

  def test_id_is_set
    assert_equal 1, inv.id 
  end
  
  def test_customer_id_is_set
    assert_equal 21, inv.customer_id
  end

  def test_merchant_id_is_set
    assert_equal 26, inv.merchant_id
  end

  def test_status_is_set
    assert_equal 'shipped', inv.status
  end
end
