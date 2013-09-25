require 'date'
require_relative 'base_unit'

class Customer < BaseUnit

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def format_time(time)
    DateTime.parse(time)
  end

end
