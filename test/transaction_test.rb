require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionTest < MiniTest::Unit::TestCase

  attr_reader :t, :se

  def setup
    @se = SalesEngine.new
    se.startup
    data = {id: '1',
	          invoice_id: '2',
	          credit_card_number: '4444',
	          credit_card_expiration_date: "",
            result: "success",
            sales_engine_reference: se 
            #created_at
            #updated_at
           }  
    @t = Transaction.new(data)
  end

  def test_it_exists
    assert_kind_of Transaction, t
  end

  def test_id_is_set
    assert_equal '1', t.id
  end

  def test_invoice_id_is_set
    assert_equal '2', t.invoice_id
  end

  def test_credit_card_number_is_set
    assert_equal '4444', t.credit_card_number
  end

  def test_credit_card_expiration_date
    assert_equal "", t.credit_card_expiration_date
  end

  def test_result_is_set
    assert_equal "success", t.result
  end

  def test_invoice_method_does_exist
    assert t.methods.include?(:invoice), "Invoice method is not defined"
  end

  def test_invoice_method_does_return_an_invoice_object
    assert_kind_of Invoice, t.invoice
  end

  def test_invoice_method_does_return_invoice_associated_with_this_transaction
    assert_equal t.invoice_id, t.invoice.id
  end

end
