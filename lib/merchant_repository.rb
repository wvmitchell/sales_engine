require_relative 'merchant'
require_relative 'base_repository'

class MerchantRepository < BaseRepository

  def default_filename
    './data/merchants.csv'
  end

end
