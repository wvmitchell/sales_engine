require_relative 'base_unit'
require_relative 'invoice'

class Invoice < BaseUnit

  def transactions
    sales_engine_reference.transaction_repository.collection_array.select do |transaction|
      transaction.invoice_id == id
    end
  end
 
  def invoice_items
    sales_engine_reference.invoice_item_repository.collection_array.select do |invoice_item|
      invoice_item.invoice_id == id
    end
  end
end
