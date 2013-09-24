require_relative 'invoice'
require_relative 'base_repository'

class InvoiceRepository < BaseRepository

  def default_filename
    './data/invoices.csv'
  end

end
