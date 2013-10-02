require_relative 'base_unit'
require_relative 'invoice'
require_relative 'item'


class Invoice < BaseUnit

  def transactions
    #sales_engine_reference.transaction_repository.collection_array.select do |transaction|
    #  transaction.invoice_id == id.to_s
    #end
    sales_engine_reference.transaction_repository.find_all_by_invoice_id(id)
  end
 
  def invoice_items
    sales_engine_reference.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.collect do |invoice_item|
      sales_engine_reference.item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def customer
    sales_engine_reference.customer_repository.find_by_id(customer_id)
  end

  def invoice_items_ids
    invoice_items.map(&:item_id)
  end

  def merchant
    sales_engine_reference.merchant_repository.find_by_id(merchant_id)
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
    all_transactions = sales_engine_reference.transaction_repository.collection_array
    transaction = {}
    transaction[:id] =(transactions.count + 1)
    transaction[:invoice_id] = id
    transaction[:credit_card_number] = data[:credit_card_number]
    transaction[:credit_card_expiration] = data[:credit_card_expiration]
    transaction[:result] = data[:result]
    transaction[:created_at] = Time.now.utc.to_s
    transaction[:updated_at] = Time.now.utc.to_s
    transaction[:sales_engine_reference] = sales_engine_reference

    all_transactions << Transaction.new(transaction)
  end
end
