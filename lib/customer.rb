require 'date'
require_relative 'base_unit'
require 'pry'

class Customer < BaseUnit

  def format_time(time)
    DateTime.parse(time)
  end

  def invoices
    @invoices ||= sales_engine_reference.invoice_repository.collection_array.select do |invoice|
      invoice.customer_id == id
    end
  end

  def transactions
    @transactions ||= sales_engine_reference.transaction_repository.collection_array.select do |trans|
      trans.invoice.customer_id == id 
    end
  end

  def favorite_merchant
    merchant_id = merchant_count.max_by { |merchant, count| count }.first
    sales_engine_reference.merchant_repository.find_by_id(merchant_id)
  end

  def successful_invoices
    @successful_invoices ||= invoices.select do |invoice|
      invoice.transactions.select do |trans|
	       trans.result == 'success'
      end
    end
  end  

  def valid_merchants
    @valid_merchants ||= successful_invoices.collect { |inv| inv.merchant  }
  end

  def merchant_count
    valid_merchants.each_with_object(Hash.new(0)) do |merchant, transaction_count|
       transaction_count[merchant.id] += 1
    end  
  end
end
