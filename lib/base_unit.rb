class BaseUnit

  attr_reader :sales_engine_reference

  def initialize(data={})
    data.keys.each do |key|
      if BaseUnit.valid_methods.include?(key)
        self.instance_variable_set( "@#{key.to_s}", data[key] )
        BaseUnit.send(:define_method, "#{key.to_s}") { self.instance_variable_get("@#{key.to_s}")}
      end
    end
  end

  def self.valid_methods
    [:id, :first_name, :last_name, :created_at, :updated_at, :item_id, :invoice_id, :quantity, :unit_price,
     :customer_id, :merchant_id, :status, :name, :description, :credit_card_number, :credit_card_expiration_date,
     :result, :sales_engine_reference]
  end
end

=begin
class Merchant

  attr_reader :id

  def initialize(params)
    params.each do |key,value|
      if respond_to?(key)
	instance_variable_set("@#{key}",value)
      end

    end
  end
end

class MerchantRepository


  def self.finder(field)
    define_method "find_by_#{field}" do |value|
      all.find_all {|item| item.send(field) == value}
    end
  end

  finder :id
  finder :name
end

module Attributes
  
  def self.included(by_who)
    by_who.extend ClassMethods
  end

  def initialize(params)
    self.class.attributes.each do |attribute|
      self.send("#{attribute}=",params[attribute])
    end
  end
  
  module ClassMethods

  def attributes
    @attributes ||= []
  end

  def attribute(name)
    attr_accessor :name

    attributes.push(name)
  end

  end
end

class Merchant
  include Attributes
  attribute :name
end

=end
