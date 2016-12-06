require 'pry'
class  RestaurantsApiCaller
  attr_reader :input
  BASE_URL = "https://data.cityofnewyork.us/resource/xx67-kt59.json"

# :name, :grade, :street, :building, :boro

    def initialize (input)
      @input = input
    end

    def fetch_restaurants
        puts "Fetching all the restaurants data!!!"
        response = RestClient.get("#{BASE_URL}#{input}")
        restaurants = JSON.parse(response)

        restaurants.each do |new_restaurant|

          if !Restaurants.all.any? do |saved_restaurant|
            saved_restaurant.name == new_restaurant['dba'] &&
             saved_restaurant.building == new_restaurant['building'] end
            Restaurants.new({
              name: new_restaurant['dba'],
              grade: new_restaurant['grade'] ||= 'Piece of shit restaurant AVOID',
              street: new_restaurant['street'],
              building: new_restaurant['building'],
              boro: new_restaurant['boro'],
              zip: new_restaurant['zip']
            })
          end

        end
        # binding.pry
    end
end
