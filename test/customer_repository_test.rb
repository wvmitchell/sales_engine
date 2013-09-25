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

  :wq
  :
  end

  def test_has_find_by_last_name_method
    assert cr.methods.include?(:find_by_last_name)
  end

  def test_create_collection_returns_array_of_unique_elements
    cust1 = {id: 1,first_name: 'Joey',last_name: 'Ondricka',created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'}
    cust2 = {id: 2,first_name: 'Cecelia',last_name: 'Osinski', created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'}
    arr = [cust1, cust2]
    cr.create_collection_from_array(arr)
    refute cr.collection_array.first.first_name == cr.collection_array.last.first_name
  end
end
