require './app'
require 'json'

def exit_option(app)
  puts 'Thank you for using this app!'
  app.save_books
  app.save_people

  exit
end

def process_choice(choice, app)
  case choice
  when '1' then app.list_books
  when '2' then app.list_people
  when '3' then app.handle_person
  when '4' then app.handle_book
  when '5' then app.handle_rental
  when '6' then app.handle_rental_list
  else puts "Invalid input. Please try again\n\n"
  end
end

def main
  puts "Welcome to School Library App!\n\n"
  app = App.new
  app.read_file
  app.read_people_file
  choice = 0
  while choice != '7'
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    choice = gets.chomp
    exit_option(app) if choice == '7'
    process_choice(choice, app)
  end
end

main
