require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < MiniTest::Unit::TestCase

  attr_reader :ir, :se

  def setup
    @se = SalesEngine.new
    se.startup
    @ir = se.invoice_repository 
  end

  def test_it_exists
    assert_kind_of InvoiceRepository, ir
  end

  def test_it_returns_an_array_on_init
    assert_kind_of Array, ir.collection_array 
  end

  def test_invoice_repository_does_return_array_of_invoices
    ir.collection_array.each { |invoice|  assert_kind_of Invoice, invoice }
  end

  def test_has_find_by_customer_id
    assert ir.methods.include?(:find_by_customer_id)
  end

  def test_has_find_all_by_customer_id
    assert ir.methods.include?(:find_all_by_customer_id)
  end

  def test_has_random_method
    assert ir.methods.include?(:random)
  end

  def test_random_does_return_an_invoice_item
    i1 = ir.random
    assert_kind_of Invoice, i1
  end

  def test_random_returns_a_random_customer
    i1 = ir.random
    i2 = ir.random
    refute_equal i1, i2
  end
end
