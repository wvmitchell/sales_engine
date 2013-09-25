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
end
