require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'

class CustomerTest < MiniTest::Unit::TestCase
  attr_reader :customer, :se

  def setup
    @se = SalesEngine.new
    se.startup

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

  def test_transactions_method_exists
    assert customer.methods.include?(:transactions)
  end  

  def test_transactions_method_returns_array
    assert_kind_of Array, customer.transactions
  end

  def test_transactions_method_returns_array_of_transactions
    customer.transactions.each do |trans|
      assert_kind_of Transaction, trans
    end
  end

  def test_transaction_method_returns_transaction_associated_with_cusomter
    customer.transactions.each do |trans|
      assert_equal customer.id, trans.invoice.customer_id
    end
  end

  def test_favorite_merchant_method_exists
    assert customer.methods.include?(:favorite_merchant)
  end  

  def test_favorite_merchant_returns_merchant_instance
    assert_kind_of Merchant, customer.favorite_merchant
  end

  def test_favorite_merchant_returns_merchant_with_most_invices
    data2 = { id: 2,
	      first_name: "Cecilia",
	      last_name: "Osinski",
              sales_engine_reference: se
            }
    customer2 = Customer.new(data2)
    assert_equal 27, customer2.favorite_merchant.id
  end

  def test_successful_invoices_exists
    assert customer.methods.include?(:successful_invoices)
  end

  def test_successful_invoices_return_an_array
    assert_kind_of Array, customer.successful_invoices
  end  

  def test_successful_invoices_returns_an_array_of_invoices
    customer.successful_invoices.each do |si|
      assert_kind_of Invoice, si
    end
  end

  def test_successful_invoices_return_array_of_invoices_that_are_successful
    customer.successful_invoices.each do |si|
      si.transactions.each do |ti|
        assert_equal 'success', ti.result
      end
    end
  end

  def test_valid_merchants_exists
    assert customer.methods.include?(:valid_merchants)
  end
  
  def test_valid_merchant_returns_array
    assert_kind_of Array, customer.valid_merchants
  end

  def test_valid_merchants_return_array_of_merchants
    customer.valid_merchants.each do |merch|
      assert_kind_of Merchant, merch
    end
  end

  def test_merchant_count_method_exists
    assert customer.methods.include?(:merchant_count)
  end

  def test_merchant_count_returns_hash
    assert_kind_of Hash, customer.merchant_count
  end

  def test_merchant_count_returns_string_keys
    customer.merchant_count.each_key do |k|
      assert_kind_of Fixnum, k
    end
  end

  def test_merchant_count_returns_int_values
    customer.merchant_count.each_value do |v|
      assert_kind_of Fixnum, v 
    end
  end
end
