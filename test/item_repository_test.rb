require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest< MiniTest::Unit::TestCase
  attr_reader :ir, :se

  def setup
    @se = SalesEngine.new
    se.invoice_item_repository
    @ir = ItemRepository.new(Item, se)
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

  def test_method_most_revenue_exists
    assert ir.methods.include?(:most_revenue)
  end

  def test_method_most_revenue_returns_array
    assert_kind_of Array, ir.most_revenue
  end

  def test_method_most_revenue_returns_array_of_items
    ir.most_revenue.each do |item|
      assert_kind_of Item, item
    end
  end

  def test_method_most_revenue_returns_requested_number_of_results
    assert_equal 5, ir.most_revenue(5).count
  end

  def test_method_most_revenue_returns_sorted_list_of_items_ordered_by_revenue_generated
    sorted_items = ir.sort_by_revenue
    sorted_items.each_with_index do |item, index|
      assert item.unit_price >= sorted_items[index+1].unit_price unless index+1 == sorted_items.count
    end
  end

end
