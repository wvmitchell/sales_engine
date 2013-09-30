require_relative 'base_unit'
require_relative 'item'
require_relative 'invoice'

class Merchant < BaseUnit

  def invoices
    sales_engine_reference.invoice_repository.collection_array.select do |invoice|
      invoice.merchant_id == id 
    end
  end
  
  def items
    sales_engine_reference.item_repository.collection_array.select do |item| 
      item.merchant_id == id
    end
  end

  def revenue(date=nil)
    date ? revenue_by_date(date) : all_revenue
  end

  def revenue_by_date(date)
    invoices_for_date(date).inject(0) do |sum, invoice|
      sum + invoice.revenue_per_invoice
    end
  end

  def all_revenue
    invoices.inject(0) do |sum, invoice|
      sum + invoice.revenue_per_invoice
    end    
  end

  def total_items_sold
    invoices.inject(0) do |sum, invoice|
      sum + invoice.invoice_items.count
    end
  end

  def invoices_for_date(date)
    invoices.select { |invoice| invoice.created_at == date }
  end

  def favorite_customer
    customer_id = customer_visits.max_by { |cust, vi| vi }.first
    sales_engine_reference.customer_repository.find_by_id(customer_id)
  end

  def customer_visits
    invoices.each_with_object(Hash.new(0)) do |invoice, hash_count|
      hash_count[invoice.customer_id] += 1
    end
  end

  def customers_with_pending_invoices
    invoices.collect do |inv|
      sales_engine_reference.customer_repository.find_by_id(inv.customer_id)
    end
  end
end
