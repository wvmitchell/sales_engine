require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Unit::TestCase
  
  attr_reader :merchant_repository

  def setup
    se = SalesEngine.new
    @merchant_repository = MerchantRepository.new(Merchant, se)
  end

  def test_it_exists
    assert_kind_of MerchantRepository, merchant_repository
  end

  def test_initialize_does_create_array
    assert_kind_of Array, merchant_repository.collection_array
  end

  def test_merchant_repository_does_return_array_of_merchants
    merchant_repository.collection_array.each { |merch| assert_kind_of Merchant, merch}
  end

  def test_has_find_by_id_method
    assert merchant_repository.methods.include?(:find_by_id)
  end

  def test_has_find_by_name_method
    assert merchant_repository.methods.include?(:find_by_name)
  end

  def test_has_find_by_created_at_method
    assert merchant_repository.methods.include?(:find_by_created_at)
  end

  def test_has_find_by_updated_at_method
    assert merchant_repository.methods.include?(:find_by_updated_at)
  end
  
  def test_has_find_all_by_id_method
    assert merchant_repository.methods.include?(:find_all_by_id)
  end

  def test_has_find_all_by_name_method
    assert merchant_repository.methods.include?(:find_all_by_name)
  end

  def test_has_find_all_bycreated_at_method
    assert merchant_repository.methods.include?(:find_all_by_created_at)
  end

  def test_has_find_all_by_updated_at_method
    assert merchant_repository.methods.include?(:find_all_by_updated_at)
  end
  
  def test_has_random_method
    assert merchant_repository.methods.include?(:random)
  end

  def test_random_does_return_a_customer
    m1 = merchant_repository.random
    assert_kind_of Merchant, m1
  end

  def test_random_returns_a_random_customer
    m1 = merchant_repository.random
    m2 = merchant_repository.random
    refute_equal m1, m2
  end

  def test_method_most_revenue_exists
    assert merchant_repository.methods.include?(:most_revenue)
  end

  def test_method_most_revenue_returns_array
    assert_kind_of Array, merchant_repository.most_revenue
  end

  def test_method_most_revenue_does_return_requested_number_of_results
    assert_equal merchant_repository.most_revenue(5).size, 5
    assert_equal merchant_repository.most_revenue(10).size, 10
  end

  def test_method_most_revenue_returns_array_of_merchants
    merchant_repository.most_revenue.each do |merchant|
      assert_kind_of Merchant, merchant
    end
  end

  def test_method_sort_merchants_exists
    assert merchant_repository.methods.include?(:sort_merchants)
  end

  def test_method_sort_merchants_returns_merchants_sorted_by_total_revenue
    sorted_merchants = merchant_repository.sort_merchants  
    sorted_merchants.each_with_index do |merchant, index|
      assert merchant.revenue >= sorted_merchants[index+1].revenue unless index+1 == sorted_merchants.count
    end
  end

  def test_method_most_items_exists
    assert merchant_repository.methods.include?(:most_items)
  end

  def test_method_most_items_returns_an_array
    assert_kind_of Array, merchant_repository.most_items
  end

  def test_method_most_items_returns_requested_number_of_results
    assert_equal 10, merchant_repository.most_items(10).count
  end

  def test_method_most_items_returns_merchants_sorted_by_total_items_sold
    sorted_merchants = merchant_repository.sort_merchants_by_items_sold
    sorted_merchants.each_with_index do |merchant, index|
      assert merchant.total_items_sold >= sorted_merchants[index+1].total_items_sold unless index+1 == sorted_merchants.count
    end
  end
end
