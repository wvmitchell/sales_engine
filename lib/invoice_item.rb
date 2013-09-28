require_relative 'base_unit'
require_relative 'invoice'

class InvoiceItem < BaseUnit

  def invoice
<<<<<<< HEAD
    sales_engine_reference.invoice_repository.collection_array.find do |invoice|
      invoice.id == invoice_id 
=======
    sales_engine_reference.invoice_repository.collection_array.find do |inv|
      inv.id == invoice_id
>>>>>>> 7be63ef206adcc563f0ec89b6e7ac0eca5af0ae1
    end
  end

  def item
<<<<<<< HEAD
    sales_engine_reference.item_repository.collection_array.find do |item|
      item.id == item_id 
=======
    sales_engine_reference.item_repository.collection_array.find do |it|
      it.id == item_id
>>>>>>> 7be63ef206adcc563f0ec89b6e7ac0eca5af0ae1
    end
  end
end
