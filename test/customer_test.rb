require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Unit::TestCase
  attr_reader :cust

  def setup
    data =  { id: 1,
    first_name: "George",
    last_name: "Washington",
    }
    @cust = Customer.new(data)
  end

  def test_it_exists
    assert_kind_of Customer, cust
  end

  def test_it_responds_to_id
    assert_equal 1, cust.id
  end

  def test_it_responds_to_first_name
    assert_equal "George", cust.first_name
  end

  def test_it_repsonds_to_last_name
    assert_equal "Washington", cust.last_name
  end

end
