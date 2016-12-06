class RestaurantsCLI

  def call
    # Prompt user for zipcode
    # create restaurant instance from data, from first dba
    # iterate over list of restaurants and dsiplay info to user(Name, Grade, Location[building,street,borough])
    # display user option for continuing
    run = 1
    welcome_message
    while run == 1
      Restaurants.clear_all
      user_option
    end
  end
  def welcome_message
    puts "\n\n\n <---Welcome to the NYC Restaurant Health Grade CLI---> \n\n\n"
  end

  def user_option
    puts "Make a choice: (1,2,3,4 or name,zip,by zip...) \n\n1.HELP\n\n 2.Search NYC Restaurants by Zip\n\n  3.Search NYC Restaurants by Name\n\n   4.Exit"
    user_answer = gets.strip.downcase

    if user_answer == "1" || user_answer == "help"
      user_option
    elsif user_answer == "2" || user_answer == "zip" || user_answer == "zipcode" || user_answer == "by zip"
      zip_option
    elsif user_answer == "3" || user_answer == "name" || user_answer == "by name"
      name_option
    # elsif user_answer == "" || user_answer == "boro" || user_answer == "by boro" || user_answer == "borough" || user_answer == "by borough"
    #   boro_option
    elsif user_answer == "4" || user_answer == "exit"
      run = 0
      puts "created by Vic and Yomi! Yelp aint got shit on US!!"
      exit
    else
      "Please pick a valid number"
      user_option
    end # End if
  end

  def zip_input
    puts "Enter a Zipcode in NY State to display restaurant inspection data:"
    input = gets.strip
    # Get data from API with zipcode query
    while input.length != 5
      puts "please enter a 5 digit zipcode:"
      input = gets.strip
    end
    input
  end

  def zip_option
    user_input = "?zipcode=#{zip_input}"
    get_data(user_input)
    display_data
  end

  def name_input
      puts "Enter a restaurant name in NYC"
      input=gets.strip
  end

  def name_option
    user_input = "?dba=#{name_input}"
    get_data(user_input)
    display_data
  end

  # def boro_input
  #   puts "Enter a NYC Boro"
  #   input=gets.strip
  # end
  #
  # def boro_option
  #   user_input = "?boro=#{boro_input}"
  #   get_data(user_input)
  #   display_data
  # end

  def get_data(user_input)
    adapter = RestaurantsApiCaller.new(user_input)
    adapter.fetch_restaurants
  end

  def display_data
    restaurants = Restaurants.all.sort {|a,b| [a.name,a.boro] <=> [b.name,b.boro] }
      puts "|--------------------------------------------------------|"
    restaurants.each_with_index do |restaurant,index|
      puts "#{index+1}."
      puts "    Name: #{restaurant.name}, GRADE: #{restaurant.grade}"
      puts "    Address: #{restaurant.building} #{restaurant.street}, #{restaurant.boro}, NY #{restaurant.zip}"
      puts "|--------------------------------------------------------|"
    end
  end
end
