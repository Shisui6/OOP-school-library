require './student'
require './teacher'
require './book'
require './rental'

class App
  attr_reader(:books, :people)

  def initialize
    @books = []
    @people = []
    @rentals = {}
  end

  def list_books
    if @books.empty?
      puts "No books saved\n\n"
    else
      @books.each { |book| puts "Title: '#{book.title}', Author: #{book.author}" }
      puts ''
    end
  end

  def list_people
    if @people.empty?
      puts "No People saved\n\n"
    else
      @people.each { |person| puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
      puts ''
    end
  end

  def create_teacher(age, name, specialization)
    teacher = Teacher.new(name, age, specialization)
    @people << teacher
    puts "Person created successfully\n\n"
  end

  def create_student(age, name, permission)
    student = Student.new(name, age, permission)
    @people << student
    puts "Person created successfully\n\n"
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts "Book created successfully\n\n"
  end

  def create_rental(date, person, book)
    rental = Rental.new(date, person, book)
    if @rentals[person.id]
      @rentals[person.id] << rental
    else
      @rentals[person.id] = [rental]
    end
    puts "Rental created successfully\n\n"
  end

  def list_rentals(id)
    if @rentals[id]
      puts 'Rentals:'
      @rentals[id].each { |rental| puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" }
      puts ''
    else
      puts ''
      puts "No rentals for this person\n\n"
    end
  end
end
