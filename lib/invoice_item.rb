require_relative 'base_unit'
require_relative 'invoice'

class InvoiceItem < BaseUnit

  def invoice
    sales_engine_reference.invoice_repository.collection_array.find do |inv|
      inv.id.to_s == invoice_id
    end
  end

  def item
    sales_engine_reference.item_repository.collection_array.find do |it|
      it.id.to_s == item_id
    end
  end
end
