require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant'

class SalesEngineTest < MiniTest::Unit::TestCase

  attr_reader :se

  def setup
    @se = SalesEngine.new
  end

  def test_it_does_exist
    assert_kind_of SalesEngine, se
  end

  def test_it_does_respond_to_startup
    assert SalesEngine.instance_methods.include?(:startup)
  end

  def test_it_does_respond_to_merchant_repos
    assert SalesEngine.instance_methods.include?(:merchant_repository)
  end

  def test_it_does_return_a_merchant_repository_instance
    assert_kind_of MerchantRepository, @se.merchant_repository
  end

  def test_it_does_respond_to_invoice_repos
    assert SalesEngine.instance_methods.include?(:invoice_repository)
  end

  def test_it_does_return_an_invoice_repository_instance
    assert_kind_of InvoiceRepository, @se.invoice_repository
  end 

  def test_it_does_respond_to_item_repos
    assert SalesEngine.instance_methods.include?(:item_repository)
  end 

  def test_it_does_return_an_item_repository_instance
    assert_kind_of ItemRepository, @se.item_repository
  end

  def test_it_does_respond_to_invoice_item_repos
    assert SalesEngine.instance_methods.include?(:invoice_item_repository)
  end

  def test_it_does_return_an_invoice_items_repository_instance
    assert_kind_of InvoiceItemRepository, @se.invoice_item_repository
  end 

  def test_it_does_respond_to_customer_repos
    assert SalesEngine.instance_methods.include?(:customer_repository)
  end

  def test_it_does_return_a_customer_repository_instance
    assert_kind_of CustomerRepository, @se.customer_repository
  end 

  def test_it_does_respond_to_transaction_repos
    assert SalesEngine.instance_methods.include?(:transaction_repository)
  end

  def test_it_does_return_a_transaction_repository_instance
    assert_kind_of TransactionRepository, @se.transaction_repository
  end

  def test_it_is_passed_to_merchant_repository
    se.merchant_repository
    assert_equal se, se.merchant_repository.sales_engine_reference
  end

  def test_it_is_passed_to_customer_repository
    se.customer_repository
    assert_equal se, se.customer_repository.sales_engine_reference
  end

  def test_it_is_passed_to_invoice_repository
    se.invoice_repository
    assert_equal se, se.invoice_repository.sales_engine_reference
  end

  def test_it_is_passed_to_item_repository
    se.item_repository
    assert_equal se, se.item_repository.sales_engine_reference
  end

  def test_it_is_passed_to_invoice_item_repository
    se.invoice_item_repository
    assert_equal se, se.invoice_item_repository.sales_engine_reference
  end

  def test_it_is_passed_to_transaction_repository
    se.transaction_repository
    assert_equal se, se.transaction_repository.sales_engine_reference
  end

  def test_it_is_passed_to_the_merchant
    se.merchant_repository
    se.merchant_repository.collection_array.each do |merchant|
      assert_equal se, merchant.sales_engine_reference
    end
  end

  def test_it_is_passed_to_the_customer
    se.customer_repository
    se.customer_repository.collection_array.each do |customer|
      assert_equal se, customer.sales_engine_reference
    end
  end

  def test_it_is_passed_to_invoice
    se.invoice_repository
    se.invoice_repository.collection_array.each do |invoice|
      assert_equal se, invoice.sales_engine_reference
    end
  end

  def test_it_is_passed_to_invoice_item
    se.invoice_item_repository

    se.invoice_item_repository.collection_array.each do |invoice_item|
      assert_equal se, invoice_item.sales_engine_reference
    end
  end

  def test_it_is_passed_to_item
    se.item_repository

    se.item_repository.collection_array.each do |item|
      assert_equal se, item.sales_engine_reference
    end
  end

  def test_it_is_passed_to_transaction
    se.transaction_repository

    se.transaction_repository.collection_array.each do |transaction|
      assert_equal se, transaction.sales_engine_reference
    end
  end

end
