require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Unit::TestCase
  
  attr_reader :mr

  def setup
    @mr = MerchantRepository.new(Merchant)
  end

  def test_it_exists
    assert_kind_of MerchantRepository, mr
  end

  def test_initialize_does_create_array
    assert_kind_of Array, mr.collection_array
  end

  def test_merchant_repository_does_return_array_of_merchants
    mr.collection_array.each { |merch| assert_kind_of Merchant, merch}
  end

  def test_has_find_by_id_method
    assert mr.methods.include?(:find_by_id)
  end

  def test_has_find_by_name_method
    assert mr.methods.include?(:find_by_name)
  end

  def test_has_find_by_created_at_method
    assert mr.methods.include?(:find_by_created_at)
  end

  def test_has_find_by_updated_at_method
    assert mr.methods.include?(:find_by_updated_at)
  end
  
  def test_has_find_all_by_id_method
    assert mr.methods.include?(:find_all_by_id)
  end

  def test_has_find_all_by_name_method
    assert mr.methods.include?(:find_all_by_name)
  end

  def test_has_find_all_bycreated_at_method
    assert mr.methods.include?(:find_all_by_created_at)
  end

  def test_has_find_all_by_updated_at_method
    assert mr.methods.include?(:find_all_by_updated_at)
  end
  
  def test_has_random_method
    assert mr.methods.include?(:random)
  end

  def test_random_does_return_a_customer
    m1 = mr.random
    assert_kind_of Merchant, m1
  end

  def test_random_returns_a_random_customer
    m1 = mr.random
    m2 = mr.random
    refute_equal m1, m2
  end
end
