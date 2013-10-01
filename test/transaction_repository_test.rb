require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < MiniTest::Unit::TestCase
  
  attr_reader :tr, :se

  def setup
    @se = SalesEngine.new
    se.startup
    @tr = se.transaction_repository 
  end

  def test_it_exists
    assert_kind_of TransactionRepository, tr
  end

  def test_it_creates_array_during_initialization
    assert_kind_of Array, tr.collection_array
  end

  def test_transaction_repository_does_return_array_of_transactions
    tr.collection_array.each {|trans| assert_kind_of Transaction, trans}
  end

  def test_has_find_by_id_method
    assert tr.methods.include?(:find_by_id)
  end

  def test_has_find_by_invoice_id_method
    assert tr.methods.include?(:find_by_invoice_id)
  end

  def test_has_find_by_credit_card_number_method
    assert tr.methods.include?(:find_by_credit_card_number)
  end

  def test_has_find_by_credit_card_expiration_date_method
    assert tr.methods.include?(:find_by_credit_card_expiration_date)
  end
  
  def test_has_find_by_result_method
    assert tr.methods.include?(:find_by_result)
  end

  def test_has_find_by_created_at_method
    assert tr.methods.include?(:find_by_created_at)
  end

  def test_has_find_by_updated_at_method
    assert tr.methods.include?(:find_by_updated_at)
  end
  
  def test_has_find_all_by_id_method
    assert tr.methods.include?(:find_all_by_id)
  end

  def test_has_find_all_by_credit_card_number_method
    assert tr.methods.include?(:find_all_by_credit_card_number)
  end

  def test_has_find_by_credit_card_expiration_date_method
    assert tr.methods.include?(:find_all_by_credit_card_expiration_date)
  end
  
  def test_has_find_all_by_result_method
    assert tr.methods.include?(:find_all_by_result)
  end

  def test_has_find_all_bycreated_at_method
    assert tr.methods.include?(:find_all_by_created_at)
  end

  def test_has_find_all_by_updated_at_method
    assert tr.methods.include?(:find_all_by_updated_at)
  end
  
  def test_has_random_method
    assert tr.methods.include?(:random)
  end

  def test_random_does_return_a_customer
    t1 = tr.random
    assert_kind_of Transaction, t1
  end

  def test_random_returns_a_random_customer
    t1 = tr.random
    t2 = tr.random
    refute_equal t1, t2
  end
end
