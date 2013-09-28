require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/invoice'

class CustomerTest < MiniTest::Unit::TestCase
  attr_reader :customer, :se

  def setup
    @se = SalesEngine.new
    data =  { id: 1,
      first_name: "George",
      last_name: "Washington",
      sales_engine_reference: se 
      }
    @customer = Customer.new(data)
  end

  def test_it_exists
    assert_kind_of Customer, customer
  end

  def test_it_responds_to_id
    assert_equal 1, customer.id
  end

  def test_it_responds_to_first_name
    assert_equal "George", customer.first_name
  end

  def test_it_repsonds_to_last_name
    assert_equal "Washington", customer.last_name
  end

  def test_invoice_method_exists
    assert customer.methods.include?(:invoices)
  end

  def test_invoice_method_returns_an_array
    assert_kind_of Array, customer.invoices 
  end

  def test_invoice_method_returns_array_of_invoices
    customer.invoices.each do |invoice|
      assert_kind_of Invoice, invoice 
    end
  end

  def test_invoice_method_returns_invoices_associated_with_customer
    customer.invoices.each do |invoice|
      assert_equal invoice.customer_id, customer.id
    end
  end

end
