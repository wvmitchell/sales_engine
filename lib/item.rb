require_relative 'base_unit'

class Item < BaseUnit

  def invoice_items
    sales_engine_reference.invoice_item_repository.collection_array.select do |ii|
      ii.item_id == id 
    end
  end

  def merchant
    sales_engine_reference.merchant_repository.collection_array.find do |mer|
      mer.id == merchant_id
    end
  end

  def revenue
    @revenue ||= invoice_items.inject(0) do |sum, invoice_item|
      sum + invoice_item.quantity.to_i * invoice_item.unit_price.to_i
    end
  end

  def num_sold
    @num_sold ||= invoice_items.inject(0) do |sum, invoice_item|
      sum + invoice_item.quantity.to_i
    end
  end 

  def best_day
   Date.parse(create_date_hash.max_by { |date, quantity| quantity }.first)
  end

  def create_date_hash
    invoice_items.each_with_object(Hash.new(0)) do |invoice_item, hash|
      date = invoice_item.invoice.created_at
      quant = invoice_item.quantity

      hash[date[0,10]] += quant.to_i unless invoice_item.invoice.pending?
    end  
  end
end
