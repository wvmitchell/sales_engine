require_relative 'base_unit'

class Item < BaseUnit

  def invoice_item
    sales_engine_reference.invoice_item_repository.collection_array.find do |ii|
      ii.item_id == id 
    end
  end

  def merchant
    sales_engine_reference.merchant_repository.collection_array.find do |mer|
      mer.id == merchant_id
    end
  end
  
end
