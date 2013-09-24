require_relative 'item'
require_relative 'base_repository'

class ItemRepository < BaseRepository

  def default_filename
    './data/items.csv'
  end
  
end
