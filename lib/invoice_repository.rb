require_relative 'invoice'
require_relative 'base_repository'

class InvoiceRepository < BaseRepository

  def default_filename
    #'./data/tmp_invoices.csv'
    './data/invoices.csv'
  end

  def create(data={})
    id = (collection_array.last.id.to_i + 1)
    customer_id = data[:customer].id
    merchant_id = data[:merchant].id
    status = data[:status]
    created_at = Time.now.utc.to_s
    updated_at = Time.now.utc.to_s

    invoice = create_invoice(id, customer_id, merchant_id, status, created_at, updated_at)
    create_invoice_items(id, data[:items])

    invoice 
  end

  def create_invoice(id, customer_id, merchant_id, status, created_at, updated_at)
    data = {}
    data[:id] = id
    data[:customer_id] = customer_id
    data[:merchant_id] = merchant_id
    data[:status] = status
    data[:created_at] = created_at
    data[:updated_at] = updated_at
    data[:sales_engine_reference] = sales_engine_reference
    inv = Invoice.new(data)
    collection_array << inv
    inv
  end

  def create_invoice_items(invoice_id, items)
    invoice_items = sales_engine_reference.invoice_item_repository.collection_array
    items.uniq.each_with_object({}) do |item, data|
      data[:id] = (invoice_items.last.id.to_i + 1)
      data[:item_id] = item.id
      data[:invoice_id] = invoice_id
      data[:quantity] = items.count(item)
      data[:unit_price] = item.unit_price
      data[:created_at] = Time.now.utc.to_s
      data[:updated_at] = Time.now.utc.to_s
      data[:sales_engine_reference] = sales_engine_reference
      
      invoice_items << InvoiceItem.new(data)
    end
  end
end
