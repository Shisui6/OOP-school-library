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

  def handle_student
    print 'Age:'
    age = gets.chomp
    print 'Name:'
    name = gets.chomp
    print 'Has parent permission? [Y/N]:'
    permission = gets.chomp.downcase
    case permission
    when 'y'
      permission = true
      create_student(age, name, permission)
    when 'n'
      permission = false
      create_student(age, name, permission)
    else
      puts "Invalid input, please try again\n\n"
    end
  end

  def handle_teacher
    print 'Age:'
    age = gets.chomp
    print 'Name:'
    name = gets.chomp
    print 'Specialization:'
    specialization = gets.chomp
    create_teacher(age, name, specialization)
  end

  def handle_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    choice = gets.chomp
    case choice
    when '1' then handle_student
    when '2' then handle_teacher
    else puts "Invalid input. Please try again\n\n"
    end
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts "Book created successfully\n\n"
  end

  def create_book_from_file(title, author)
    book = Book.new(title, author)
    @books << book
  end

  def handle_book
    print 'Title:'
    title = gets.chomp
    print 'Author:'
    author = gets.chomp
    create_book(title, author)
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

  def rental_check(book, person)
    if @books[book.to_i].nil? || @people[person.to_i].nil? || book.length > 1 || person.length > 1
      puts "Invalid input. Please try again\n\n"
    else
      puts ''
      print 'Date:'
      date = gets.chomp
      create_rental(date, @people[person.to_i], @books[book.to_i])
    end
  end

  def handle_rental
    if @books.empty?
      puts "No books saved\n\n"
    else
      puts 'Select a book from the following list by number'
      @books.each { |book| puts "#{@books.index book}) Title: '#{book.title}', Author: #{book.author}" }
      book = gets.chomp

      puts ''
      puts 'Select a person from the following list by number(not id)'
      @people.each do |pers|
        puts "#{@people.index pers}) [#{pers.class.name}] Name: #{pers.name}, ID: #{pers.id}, Age: #{pers.age}"
      end
      person = gets.chomp

      rental_check(book, person)
    end
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

  def handle_rental_list
    print 'ID of person: '
    id = gets.chomp
    list_rentals(id)
  end

  def save_books
    arr = []
    @books.each do |book|
      arr << {
        title: book.title,
        author: book.author
      }
    end
    File.write('books.json', JSON.generate(arr))
  end

  def save_people
    arr = []
    @people.each do |person|

      if person.class.name == 'Teacher'
        arr << {
          name: person.name,
          age: person.age,
          specialization: person.specialization
        }
      else
        arr << {
          name: person.name,
          age: person.age,
          permission: person.parent_permission
        }
      end
    end
    File.write('people.json', JSON.generate(arr))
  end

  def read_file
    return unless File.exist?('books.json')

    content = JSON.parse(File.read('books.json'))
    content.each { |item| create_book_from_file(item['title'], item['author']) }
  end

  def read_people_file
    return unless File.exist?('people.json')

    content = JSON.parse(File.read('people.json'))
    content.each { |item| 
      if item['specialization']
      create_book_from_file(item['title'], item['author'])
        teacher = Teacher.new(item['name'], item['age'], item['specialization'])
        @people << teacher
      else
        student = Student.new(item['name'], item['age'], item['permission'])
        @people << student
      end
    }
  end
end
