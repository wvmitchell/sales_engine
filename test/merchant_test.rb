require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < MiniTest::Unit::TestCase
  
  attr_reader :m

  def setup
    data = {id: 1,
	    name: "AwesomeBar"
	    #created_at
	    #updated_at
           }
    @m = Merchant.new(data)
  end

  def test_it_exists
    assert_kind_of Merchant, m
  end
  
  def test_id_is_set
    assert_equal 1, m.id
  end

  def test_name_is_set
    assert_equal "AwesomeBar", m.name
  end
end
