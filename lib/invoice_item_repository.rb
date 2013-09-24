require_relative 'invoice_item'
require_relative 'base_repository'

class InvoiceItemRepository < BaseRepository

  def default_filename
    './data/invoice_items.csv'
  end

end
