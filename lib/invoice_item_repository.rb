require_relative 'invoice_item'
require_relative 'base_repository'

class InvoiceItemRepository < BaseRepository

  def default_filename
    #'./data/tmp_invoice_items.csv'
    './data/invoice_items.csv'
  end

  def find_all_by_invoice_id(invoice_id)
   # collection_array.find_all do |invoice_item|
   #   invoice_item.invoice_id.to_s == invoice_id.to_s
   # end
   "testing"
  end

  def successful_invoice_items
    @successful_invoice_items ||= collection_array.reject do |ii|
      ii.invoice.pending?
    end
  end

end
