require_relative 'merchant'
require_relative 'base_repository'

class MerchantRepository < BaseRepository

  def default_filename
    './data/tmp_merchants.csv'
    #'./data/merchants.csv'
  end

  def most_revenue(number_of_results = 1)
    sort_merchants[0,number_of_results]
  end

  def sort_merchants
    collection_array.sort_by {|merchant| merchant.revenue}.reverse
  end
end
