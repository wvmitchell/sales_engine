require_relative 'customer'
require_relative 'invoice'
require_relative 'invoice_item'
require_relative 'item'
require_relative 'merchant'
require_relative 'transaction'

class BaseRepository

  attr_accessor :collection_array, :class_type

  def initialize(class_type)
    @collection_array = create_collection
    @class_type = valid?(class_type) ? class_type : exit_error(class_type)
  end

  def default_filename
    ""
  end

  def create_collection

  end

  def valid?(class_type)
    [Customer, Invoice, InvoiceItem, Item, Merchant, Transaction].include?(class_type)
  end

  def exit_error(class_type)
    raise "Sorry, there is not #{class_type}Repository class" 
  end

end