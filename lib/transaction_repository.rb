require_relative 'transaction'
require_relative 'base_repository'

class TransactionRepository < BaseRepository
  
  def default_file
    './data/transactions.csv'
  end

end
