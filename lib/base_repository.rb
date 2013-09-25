require_relative 'customer'
require_relative 'invoice'
require_relative 'invoice_item'
require_relative 'item'
require_relative 'merchant'
require_relative 'transaction'
require 'csv'
class BaseRepository

  attr_accessor :collection_array, :class_type, :default_filename, :attributes, :csv_obj

  def initialize(class_type)
    @class_type = valid?(class_type) ? class_type : exit_error(class_type)
    #@collection_array = create_collection
    create_collection

    attributes.each do |attribute| 
      self.class.send(:define_method, "find_by_#{attribute}") do |match|
       	collection_array.find { |item| item.send("#{attribute}").downcase ==  match.downcase }
      end
    end      
  end

  def create_collection
    @collection_array = create_csv_object.map do |row|
      class_type.new(row.to_hash)
    end 
  end

  def create_collection_from_array(array)
    arr = []
    array.each do |item|
      arr << class_type.new(item)
    end
    arr
  end

  def clean_hash(hash)
    new_hash = {}
    hash.each do |key, value|
      new_hash[key] = value.to_s
    end
    new_hash
  end

  def valid?(class_type)
    [Customer, Invoice, InvoiceItem, Item, Merchant, Transaction].include?(class_type)
  end

  def exit_error(class_type)
    raise "Sorry, there is not #{class_type}Repository class" 
  end

  def create_csv_object
    @csv_obj = CSV.read default_filename, "r", headers: true, header_converters: :symbol 
  end

  def attributes
    @attributes ||= create_csv_object.headers
  end
  
  
end
