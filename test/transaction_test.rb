require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'

class TransactionTest < MiniTest::Unit::TestCase

  attr_reader :t

  def setup
    data = {id: 1,
	    invoice_id: 2,
	    credit_card_number: 4444,
	    credit_card_expiration_date: "",
            result: "success"
            #created_at
            #updated_at
           }  
    @t = Transaction.new(data)
  end

  def test_it_exists
    assert_kind_of Transaction, t
  end

  def test_id_is_set
    assert_equal 1, t.id
  end

  def test_invoice_id_is_set
    assert_equal 2, t.invoice_id
  end

  def test_credit_card_number_is_set
    assert_equal 4444, t.credit_card_number
  end

  def test_credit_card_expiration_date
    assert_equal "", t.credit_card_expiration_date
  end

  def test_result_is_set
    assert_equal "success", t.result
  end
end
