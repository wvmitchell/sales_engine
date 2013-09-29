require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine

  def initialize(data='./data')
  end
  def startup
    merchant_repository
    invoice_repository
    item_repository
    invoice_item_repository
    customer_repository
    transaction_repository
  end

  def merchant_repository
    @merchant_repository ||= MerchantRepository.new(Merchant, self) 
  end

  def invoice_repository
    @invoice_repository ||= InvoiceRepository.new(Invoice, self)
  end

  def item_repository
    @item_repository ||= ItemRepository.new(Item, self)
  end

  def invoice_item_repository
    @invoice_item_repository ||= InvoiceItemRepository.new(InvoiceItem, self)
  end

  def customer_repository
    @customer_repository ||= CustomerRepository.new(Customer, self)
  end

  def transaction_repository
    @transaction_repository ||= TransactionRepository.new(Transaction, self)
  end
end
