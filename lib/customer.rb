require 'date'
require_relative 'base_unit'

class Customer < BaseUnit

  def format_time(time)
    DateTime.parse(time)
  end

end
