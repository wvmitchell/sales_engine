require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < MiniTest::Unit::TestCase

  attr_reader :cr

  def setup
    @cr = CustomerRepository.new(Customer)
  end

  def test_it_exists
    assert_kind_of CustomerRepository, cr 
  end

  def test_it_does_create_an_array
    assert_kind_of Array, cr.collection_array 
  end

  def test_customer_repository_does_return_array_of_customer
    cr.collection_array.each { |customer|  assert_kind_of Customer, customer }
  end

  def test_has_find_by_id_method
    assert cr.methods.include?(:find_by_id)
  end

  def test_has_find_by_last_name_method
    assert cr.methods.include?(:find_by_last_name)
  end

  def test_has_find_all_by_last_name
    assert cr.methods.include?(:find_all_by_last_name)
  end

  def test_has_random_method
    assert cr.methods.include?(:random)
  end

  def test_random_does_return_a_customer
    cust1 = cr.random
    assert_kind_of Customer, cust1
  end

  def test_random_returns_a_random_customer
    cust1 = cr.random
    cust2 = cr.random
    refute_equal cust1, cust2
  end

  def test_repository_does_hold_reference_to_sales_engine
    cr2 = CustomerRepository.new(Customer, SalesEngine.new)
    assert_kind_of SalesEngine, cr2.sales_engine_reference
  end

end
