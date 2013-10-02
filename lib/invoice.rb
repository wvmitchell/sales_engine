require_relative 'base_unit'
require_relative 'invoice'
require_relative 'item'


class Invoice < BaseUnit

  def transactions
    sales_engine_reference.transaction_repository.collection_array.select do |transaction|
      transaction.invoice_id == id.to_s
    end
  end
 
  def invoice_items
    sales_engine_reference.invoice_item_repository.collection_array.select do |invoice_item|
      invoice_item.invoice_id == id.to_s 
    end
  end

  def items
    sales_engine_reference.item_repository.collection_array.select do |item|
      invoice_items_ids.include?(item.id)
    end
  end

  def customer
    sales_engine_reference.customer_repository.collection_array.find do |customer|
      customer.id == customer_id
    end
  end

  def invoice_items_ids
    invoice_items.map(&:item_id)
  end

  def merchant
    sales_engine_reference.merchant_repository.collection_array.find do |merchant|
      merchant.id.to_s == merchant_id 
    end
  end

  def revenue_per_invoice
    invoice_items.inject(0) do |sum, invoice_item| 
      sum + invoice_item.unit_price.to_i 
    end
  end

  def pending?
    transactions.all? { |transaction| transaction.result == "failed" }
  end  

  def charge(data)
    transactions = sales_engine_reference.transaction_repository.collection_array
    transaction = {}
    transaction[:id] =(transactions.count + 1)
    transaction[:invoice_id] = id
    transaction[:credit_card_number] = data[:credit_card_number]
    transaction[:credit_card_expiration] = data[:credit_card_expiration]
    transaction[:result] = data[:result]
    transaction[:created_at] = Time.now.utc.to_s
    transaction[:updated_at] = Time.now.utc.to_s
    transaction[:sales_engine_reference] = sales_engine_reference

    transactions << Transaction.new(transaction)
  end
end
