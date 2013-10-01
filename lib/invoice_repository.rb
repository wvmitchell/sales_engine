require_relative 'invoice'
require_relative 'base_repository'

class InvoiceRepository < BaseRepository

  def default_filename
    #'./data/tmp_invoices.csv'
    './data/invoices.csv'
  end

  def create(data={})
    id = collection_array.last.id + 1
    customer_id = data[:customer].id
    merchant_id = data[:merchant].id
    status = data[:status]
    created_at = Time.now.utc.to_s
    updated_at = Time.now.utc.to_s

    create_invoice(id, custmer_id, merchant_id, status, created_at, updated_at)
    create_invoice_items(id, data[:items])
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
    collection_array << Invoice.new(data)
  end

end
