require_relative 'merchant'
require_relative 'base_repository'

class MerchantRepository < BaseRepository

  def default_filename
    './data/tmp_merchants.csv'
    #'./data/merchants.csv'
  end

  def most_revenue(number_of_results = 1)
    sort_merchants.take(number_of_results)
  end

  def most_items(number_of_results = 1)
    sort_merchants_by_items_sold.take(number_of_results)
  end

  def sort_merchants
    collection_array.sort_by {|merchant| merchant.revenue}.reverse
  end

  def sort_merchants_by_items_sold
    collection_array.sort_by {|merchant| merchant.total_items_sold}.reverse
  end
end
