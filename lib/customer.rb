require 'date'
require_relative 'base_unit'

class Customer < BaseUnit

  def format_time(time)
    DateTime.parse(time)
  end

  def invoices
    sales_engine_reference.invoice_repository.collection_array.select do |invoice|
      invoice.customer_id == id
    end
  end
end
