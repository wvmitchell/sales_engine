require_relative 'base_unit'
class Transaction < BaseUnit

  def invoice
    #sales_engine_reference.invoice_repository.collection_array.find do |inv|
    #  inv.id.to_s == invoice_id
    #end

    sales_engine_reference.invoice_repository.find_by_id(invoice_id)
  end
 
end
