require_relative 'base_unit'
require_relative 'item'

class Merchant < BaseUnit
  
  def items
    sales_engine_reference.item_repository.collection_array.select do |item| 
      item.merchant_id == id
    end
  end
end
