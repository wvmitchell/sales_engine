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
    date ? revenue_by_date : all_revenue
    invoices_for_date(date).inject(0) do |sum, invoice|
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
end
