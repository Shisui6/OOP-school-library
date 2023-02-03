require './app'

def display_menu
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def handle_student(app)
  print 'Age:'
  age = gets.chomp
  print 'Name:'
  name = gets.chomp
  print 'Has parent permission? [Y/N]:'
  permission = gets.chomp.downcase
  case permission
  when 'y'
    permission = true
    app.create_student(age, name, permission)
  when 'n'
    permission = false
    app.create_student(age, name, permission)
  else
    puts "Invalid input, please try again\n\n"
  end
end

def handle_teacher(app)
  print 'Age:'
  age = gets.chomp
  print 'Name:'
  name = gets.chomp
  print 'Specialization:'
  specialization = gets.chomp
  app.create_teacher(age, name, specialization)
end

def person_option(app)
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
  choice = gets.chomp
  case choice
  when '1' then handle_student(app)
  when '2' then handle_teacher(app)
  else puts "Invalid input. Please try again\n\n"
  end
end

def book_option(app)
  print 'Title:'
  title = gets.chomp
  print 'Author:'
  author = gets.chomp
  app.create_book(title, author)
end

def rental_check(app, book, person)
  if app.books[book.to_i].nil? || app.people[person.to_i].nil? || book.length > 1 || person.length > 1
    puts "Invalid input. Please try again\n\n"
  else
    puts ''
    print 'Date:'
    date = gets.chomp
    app.create_rental(date, app.people[person.to_i], app.books[book.to_i])
  end
end

def rental_option(app)
  if app.books.empty?
    puts "No books saved\n\n"
  else
    puts 'Select a book from the following list by number'
    app.books.each { |book| puts "#{app.books.index book}) Title: '#{book.title}', Author: #{book.author}" }
    book = gets.chomp

    puts ''
    puts 'Select a person from the following list by number(not id)'
    app.people.each do |pers|
      puts "#{app.people.index pers}) [#{pers.class.name}] Name: #{pers.name}, ID: #{pers.id}, Age: #{pers.age}"
    end
    person = gets.chomp

    rental_check(app, book, person)
  end
end

def rental_list_option(app)
  print 'ID of person: '
  id = gets.chomp
  app.list_rentals(id)
end

def exit_option
  puts 'Thank you for using this app!'
  exit
end

def process_choice(choice, app)
  case choice
  when '1' then app.list_books
  when '2' then app.list_people
  when '3' then person_option(app)
  when '4' then book_option(app)
  when '5' then rental_option(app)
  when '6' then rental_list_option(app)
  else puts "Invalid input. Please try again\n\n"
  end
end

def main
  puts "Welcome to School Library App!\n\n"
  app = App.new
  choice = 0
  while choice != '7'
    display_menu
    choice = gets.chomp
    exit_option if choice == '7'
    process_choice(choice, app)
  end
end

main
