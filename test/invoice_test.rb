require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require './lib/sales_engine'

class InvoiceTest < MiniTest::Unit::TestCase

  attr_reader :inv, :se

  def setup
    @se = SalesEngine.new
    se.transaction_repository

    data =  { id: '1',
    customer_id: '21',
    merchant_id: '26',
    status: 'shipped',
    sales_engine_reference: se 
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
      assert_equal inv.id, transaction.invoice_id
    end
  end
end
