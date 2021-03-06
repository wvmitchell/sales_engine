require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item'

class InvoiceTest < MiniTest::Unit::TestCase

  attr_reader :inv, :se, :first_trans

  def setup
    @se = SalesEngine.new
    se.startup
    data =  { id: 1,
    customer_id: 2,
    merchant_id: '2',
    status: 'shipped',
    sales_engine_reference: se 
    }
    @inv = Invoice.new(data)

    @first_trans = inv.sales_engine_reference.transaction_repository.collection_array
  end

  def teardown
   transactions = inv.sales_engine_reference.transaction_repository.collection_array
   transactions.pop unless transactions.count <=  first_trans.count
  end 
  def test_it_exists
    assert_kind_of Invoice, inv
  end

  def test_id_is_set
    assert_equal 1, inv.id 
  end
  
  def test_customer_id_is_set
    assert_equal 2, inv.customer_id
  end

  def test_merchant_id_is_set
    assert_equal '2', inv.merchant_id
  end

  def test_status_is_set
    assert_equal 'shipped', inv.status
  end

  def test_method_transactions_exists
    assert inv.methods.include?(:transactions)
  end

  def test_method_transactions_returns_an_array
    assert_kind_of Array, inv.transactions
  end

  def test_method_transactions_is_not_empty
    refute inv.transactions.empty?
  end

  def test_transactions_method_returns_array_of_transactions
    inv.transactions.each do |transaction|
      assert_kind_of Transaction, transaction
    end
  end

  def test_all_transactions_match_invoice_id
    inv.transactions.each do |transaction|
      assert_equal inv.id, transaction.invoice_id.to_i 
    end
  end

  def test_method_invoice_items_method_exists
    assert inv.methods.include?(:invoice_items)
  end

  def test_method_invoice_items_returns_array
    assert_kind_of Array, inv.invoice_items
  end

  def test_method_invoice_items_is_not_empty
    refute inv.invoice_items.empty?
  end

  def test_method_invoice_items_returns_array_of_invoice_items
    inv.invoice_items.each do |invoice_item|
      assert_kind_of InvoiceItem, invoice_item
    end
  end

  def test_method_invoice_items_match_invoice_id
    inv.invoice_items.each do |invoice_item|
      assert_equal inv.id, invoice_item.invoice_id.to_i
    end
  end

  def test_method_items_exists
    assert inv.methods.include?(:items)
  end

  def test_method_items_returns_an_array
    assert_kind_of Array, inv.items 
  end

  def test_method_items_is_not_empty
    skip
    refute inv.items.empty?
  end

  def test_items_method_returns_array_of_items
    inv.items.each do |item|
      assert_kind_of Item, item
    end
  end

  def test_invoice_items_ids_returns_an_array
    assert_kind_of Array, inv.invoice_items_ids
  end

  def test_customer_method_exists
    assert inv.methods.include?(:customer)
  end

  def test_customer_method_returns_a_customer_type
    assert_kind_of Customer, inv.customer
  end

  def test_customer_method_returns_customer_with_id_equal_to_customer_id_on_invoice
    assert_equal inv.customer_id, inv.customer.id 
  end
  
  def test_merchant_method_exists
    assert inv.methods.include?(:merchant)
  end

  def test_merchant_method_returns_merchant_type
    assert_kind_of Merchant, inv.merchant
  end

  def test_merchant_method_returns_merchant_with_id_equal_to_merchant_id_on_invoice
    assert_equal inv.merchant_id, inv.merchant.id.to_s
  end

  def test_revenue_per_invoice_method_exists
    assert inv.methods.include?(:revenue_per_invoice), "No revenue_per_invoice method defined"
  end

  def test_revenue_per_invoice_method_returns_fixnum
    assert_kind_of BigDecimal, inv.revenue_per_invoice
  end

  def test_pending_method_exists
    assert inv.methods.include?(:pending?)
  end

  def test_pending_returns_true_if_no_sucesses
    data2 = { id: 13, sales_engine_reference: se }
    inv2 = Invoice.new(data2)
    assert inv2.pending?
  end

  def test_charge_method_exists
    assert inv.methods.include?(:charge)
  end

  def test_charge_method_creates_transaction
    first_count = inv.transactions.count
    inv.charge(credit_card_number: "11111111111111", credit_card_expiration: "01/01", result: "success")
    second_count = inv.transactions.count
    assert_equal first_count + 1, second_count
  end

  def test_charge_method_creates_into_total_transactions
    first_count = inv.sales_engine_reference.transaction_repository.collection_array.count
    inv.charge(credit_card_number: "11111111111111", credit_card_expiration: "01/01", result: "success")
    second_count = inv.sales_engine_reference.transaction_repository.collection_array.count
    assert_equal first_count + 1, second_count
  end
end
