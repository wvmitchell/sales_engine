require_relative 'base_unit'
class Transaction < BaseUnit

  def invoice
    sales_engine_reference.invoice_repository.collection_array.find do |inv|
      inv.id == invoice_id
    end
  end
 
end
