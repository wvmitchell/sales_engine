require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class ItemRepositoryTest< MiniTest::Unit::TestCase
  attr_reader :ir

  def setup
    @ir = ItemRepository.new(Item)
  end

  def test_it_exists
    assert_kind_of ItemRepository, ir
  end

  def test_does_it_create_array_on_initialize
    assert_kind_of Array, ir.collection_array
  end

  def test_item_repository_does_return_array_of_item
    ir.collection_array.each { |item|  assert_kind_of Item, item }
  end

  def tests_has_find_by_id_method
    assert ir.methods.include?(:find_by_id)
  end

  def test_has_find_by_name_method
    assert ir.methods.include?(:find_by_name)
  end

  def test_has_find_by_description_method
    assert ir.methods.include?(:find_by_description)
  end

  def test_has_find_by_created_at_method
    assert ir.methods.include?(:find_by_created_at)
  end

  def test_has_find_by_created_at_method
    assert ir.methods.include?(:find_by_updated_at)
  end

  def test_has_random_method
    assert ir.methods.include?(:random)
  end

  def tests_has_find_all_by_id_method
    assert ir.methods.include?(:find_all_by_id)
  end

  def test_has_find_all_by_name_method
    assert ir.methods.include?(:find_all_by_name)
  end

  def test_has_find_all_by_description_method
    assert ir.methods.include?(:find_all_by_description)
  end

  def test_has_find_all_by_created_at_method
    assert ir.methods.include?(:find_all_by_created_at)
  end

  def test_has_find_all_by_created_at_method
    assert ir.methods.include?(:find_all_by_updated_at)
  end

  def test_random_does_return_an_item
    i1 = ir.random
    assert_kind_of Item, i1
  end

  def test_random_returns_a_random_item
    i1 = ir.random
    i2 = ir.random
    refute_equal i1, i2
  end

end
