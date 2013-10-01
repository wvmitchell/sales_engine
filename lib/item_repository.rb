require_relative 'item'
require_relative 'base_repository'

class ItemRepository < BaseRepository

  def default_filename
    #'./data/tmp_items.csv'
    './data/items.csv'
  end

  def most_revenue(x=1)
    sort_by_revenue.take(x)
  end 

  def sort_by_revenue
    collection_array.sort_by {|item| item.revenue }.reverse
  end
end
