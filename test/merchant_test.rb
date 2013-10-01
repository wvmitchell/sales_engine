require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/item'
require './lib/sales_engine'
require './lib/invoice'
require 'pry'

class MerchantTest < MiniTest::Unit::TestCase
  
  attr_reader :m, :se

  def setup
    @se = SalesEngine.new
    se.startup
    data = { id: "27",
	           name: "AwesomeBar",
	           sales_engine_reference: se
           }
    @m = Merchant.new(data)
  end

  def test_it_exists
    assert_kind_of Merchant, m
  end
  
  def test_id_is_set
    assert_equal "27", m.id
  end

  def test_name_is_set
    assert_equal "AwesomeBar", m.name
  end

  def test_items_method_exists
    assert m.methods.include?(:items)
  end

  def test_items_metod_returns_array
    assert_kind_of Array, m.items
  end

  def test_items_is_not_empty
    skip
    refute m.items.empty?
  end

  def tests_items_method_returns_array_of_item_objects
    m.items.each do |item|
      assert_kind_of Item, item
    end
  end

  def test_items_has_same_id_as_self
    m.items.each do |item|
      assert_equal item.merchant_id, m.id
    end  
  end

  def test_invoices_method_exists
    assert m.methods.include?(:invoices)
  end

  def test_invoices_method_returns_an_array
    assert_kind_of Array, m.invoices
  end

  def test_invoices_is_not_empty
    skip
    refute m.invoices.empty?
  end

  def test_invoices_method_returns_array_of_invoices
    m.invoices.each do |invoice|
      assert_kind_of Invoice, invoice
    end
  end

  def test_invoices_each_have_same_merchant_id_as_self
    m.invoices.each do |invoice|
      assert_equal m.id, invoice.merchant_id
    end
  end

  def test_revenue_method_exists
    assert m.methods.include?(:revenue), "No revenue method defined"
  end

  def test_revenue_method_does_return_fixnum
    assert_kind_of BigDecimal, m.revenue
  end

  def test_revenue_does_return_sum_of_revenue_from_assosciated_invoices
    total_revenue = 0
    m.invoices.each do |invoice|
      total_revenue += invoice.revenue_per_invoice
    end
    assert_equal BigDecimal(total_revenue)/100, m.revenue
  end

  def test_revenue_accepts_a_date_parameter
    m.revenue("2012-03-27 14:53:59 UTC")
    assert_silent {"Date note accepted" }
  end 

  def test_revenue_only_with_specified_date
    total_revenue = 0
    m.invoices_for_date("2012-03-27 14:53:59 UTC").each do |invoice|
      total_revenue += invoice.revenue_per_invoice
    end
    assert_equal total_revenue, m.revenue("2012-03-27 14:53:59 UTC")
  end

  def test_method_favorite_customer_exists
    assert m.methods.include?(:favorite_customer)
  end 

  def test_favorite_customer_returns_a_customer_object
    assert_kind_of Customer, m.favorite_customer
  end

  def test_customer_id_exists_within_merchant_invoices
    assert m.invoices.collect {|invoice| invoice.customer_id }.include?(m.favorite_customer.id)
  end 
  
  def test_favorite_customer_returns_customer_with_max_transaction
    customer_visits =  m.invoices.each_with_object(Hash.new(0)) do |inv, hash_count|
      hash_count[inv.customer_id] += 1
    end

    customer_id = customer_visits.max_by { |cust, vi| vi }.first

    assert_equal customer_id, m.favorite_customer.id
  end  

  def test_customers_with_pending_invoices_method_exists
    assert m.methods.include?(:customers_with_pending_invoices)
  end  

  def test_customers_with_pending_invoices_returns_array
    assert_kind_of Array, m.customers_with_pending_invoices
  end

  def test_customers_with_pending_invoices_returns_array_of_customers
    m.customers_with_pending_invoices.each do |customer|
      assert_kind_of Customer, customer
    end
  end

  def test_customer_with_pending_invoices_returns_array_of_customers_with_unsuccesful_transactions
    data2 = {id: "34", sales_engine_reference: se}
    m2 = Merchant.new(data2)
    m2.customers_with_pending_invoices.each do |customer|
      customer.invoices.each do |invoice|
	      if invoice.merchant_id == m2.id 
          assert invoice.pending?
        end
      end
    end
  end

  def test_method_successful_invoices_exists
    assert m.methods.include?(:successful_invoices)
  end
end
