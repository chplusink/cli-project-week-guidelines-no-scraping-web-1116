require 'pry'

class Restaurants
  attr_accessor :name, :grade, :street, :building, :boro, :zip

  ALL = []

  def self.all
    ALL
  end

  def self.clear_all
    ALL.clear
  end

  def initialize(attributes)
    attributes.each do |key, value|
      self.send(("#{key}="), value)
    end

    self.class.all << self
    # binding.pry
  end

end
