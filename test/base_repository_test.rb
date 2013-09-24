require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/base_repository'
require_relative '../lib/customer'

class BaseRepositoryTest < MiniTest::Unit::TestCase

  attr_reader :br

  def setup
    @br = BaseRepository.new(Customer)
  end

  def test_it_exists
    assert_kind_of BaseRepository, br 
  end

  def test_it_has_a_collection_array
    assert br.methods.include?(:collection_array)
  end

  def test_it_does_not_accept_invalid_class_types
    assert_raises(RuntimeError) {BaseRepository.new(Array)}
  end

end
