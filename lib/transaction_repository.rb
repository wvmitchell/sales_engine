require_relative 'transaction'
require_relative 'base_repository'

class TransactionRepository < BaseRepository
  
  def default_filename
    #'./data/tmp_transactions.csv'
    './data/transactions.csv'
  end

end
