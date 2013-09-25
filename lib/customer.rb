require 'date'
require_relative 'base_unit'

class Customer < BaseUnit

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(data={})
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def format_time(time)
    DateTime.parse(time)
  end
  
end
