require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/item'
require './lib/sales_engine'
require './lib/invoice'

class MerchantTest < MiniTest::Unit::TestCase
  
  attr_reader :m, :se

  def setup
    @se = SalesEngine.new
    se.invoice_repository
    data = { id: "27",
	           name: "AwesomeBar",
	           sales_engine_reference: se
           }
    @m = Merchant.new(data)
  end

  def test_it_exists
    assert_kind_of Merchant, m
  end
  
  def test_id_is_set
    assert_equal "27", m.id
  end

  def test_name_is_set
    assert_equal "AwesomeBar", m.name
  end

  def test_items_method_exists
    assert m.methods.include?(:items)
  end

  def test_items_metod_returns_array
    assert_kind_of Array, m.items
  end

  def test_items_is_not_empty
      skip
    refute m.items.empty?
  end

  def tests_items_method_returns_array_of_item_objects
    m.items.each do |item|
      assert_kind_of Item, item
    end
  end

  def test_items_has_same_id_as_self
    m.items.each do |item|
      assert_equal item.merchant_id, m.id
    end  
  end

  def test_invoices_method_exists
    assert m.methods.include?(:invoices)
  end

  def test_invoices_method_returns_an_array
    assert_kind_of Array, m.invoices
  end

  def test_invoices_is_not_empty
  skip
    refute m.invoices.empty?
  end

  def test_invoices_method_returns_array_of_invoices
    m.invoices.each do |invoice|
      assert_kind_of Invoice, invoice
    end
  end

  def test_invoices_each_have_same_merchant_id_as_self
    m.invoices.each do |invoice|
      assert_equal m.id, invoice.merchant_id
    end
  end

  def test_revenue_method_exists
    assert m.methods.include?(:revenue), "No revenue method defined"
  end

  def test_revenue_method_does_return_fixnum
    assert_kind_of Fixnum, m.revenue
  end

  def test_revenue_does_return_sum_of_revenue_from_assosciated_invoices
    total_revenue = 0
    m.invoices.each do |invoice|
      total_revenue += invoice.revenue_per_invoice
    end
    assert_equal total_revenue, m.revenue
  end
end
