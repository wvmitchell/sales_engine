require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < MiniTest::Unit::TestCase

  attr_reader :iir

  def setup
    @iir = InvoiceItemRepository.new(InvoiceItem)
  end

  def test_it_exists
    assert_kind_of InvoiceItemRepository, iir
  end

  def test_it_creates_an_array_on_initialize
    assert_kind_of Array, iir.collection_array
  end

  def test_invoice_item_repository_does_return_array_of_invoiceitems
    iir.collection_array.each {|ii| assert_kind_of InvoiceItem, ii}
  end

  def test_has_find_by_item_id
    assert iir.methods.include?(:find_by_item_id)
  end

  def test_has_find_all_by_item_id
    assert iir.methods.include?(:find_all_by_item_id)
  end

  def test_has_random_method
    assert iir.methods.include?(:random)
  end

  def test_random_does_return_an_invoice_item
    ii1 = iir.random
    assert_kind_of InvoiceItem, ii1
  end

  def test_random_returns_a_random_customer
    ii1 = iir.random
    ii2 = iir.random
    refute_equal ii1, ii2
  end

end
