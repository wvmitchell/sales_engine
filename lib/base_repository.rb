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
    @collection_array = create_collection
    define_find_by_methods
    define_find_by_all_methods
  end

  def create_collection
    create_csv_object.map do |row|
      class_type.new(clean_hash row.to_hash)
    end 
  end

  def define_find_by_methods
    attributes.each do |attribute| 
      self.class.send(:define_method, "find_by_#{attribute}") do |match|
        collection_array.find { |item| item.instance_variable_get("@#{attribute}").downcase ==  match.to_s.downcase }
      end
    end      
  end

  def define_find_by_all_methods
    attributes.each do |attribute| 
      self.class.send(:define_method, "find_all_by_#{attribute}") do |match|
        collection_array.find_all { |item| item.instance_variable_get("@#{attribute}").downcase ==  match.to_s.downcase }
      end
    end 
  end

  def random
    collection_array[rand(collection_array.count-1)]
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
