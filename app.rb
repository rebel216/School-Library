require_relative './students'
require_relative './teachers'
require_relative './book'
require_relative './rental'
require 'date'

class App
  def initialize
    @people = []
    @book = []
    @rentals = []
  end

  def run
    puts 'Welcome to school library App!'
    puts ''
    puts ''
    puts 'Please put an option by entering a number!'
    until list_options
      input = gets.chomp
      if input == '7'
        puts 'Thanks for using School Library App (^_^)'
        break
      end
      option(input)
    end
  end

  def list_options
    puts '1 - List all books'
    puts '2 - List all People'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - list all rentals for a given person id'
    puts '7 - Exit'
  end

  def option(input)
    case input
    when '1'
      list_books
    when '2'
      list_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals
    else
      'Enter digit from 1 to 7'
    end
  end

  def list_people
    if @people.empty?
      puts 'No people found!'
      back_to_menu
    end
    @people.each_with_index do |person, i|
      puts "#{i}) [#{person.class}] Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @book.push(book)
    puts 'Book Successfully created'
  end

  def list_books
    if @book.empty?
      puts 'No Book found!'
      back_to_menu
    end
    @book.each_with_index do |text, i|
      puts "#{i}) Title: #{text.title}, Author: #{text.author} "
    end
  end

  def create_rental
    puts 'Select a book from the following list by number (not id)'
    list_books
    book_index = gets.chomp.to_i
    book = @book[book_index]

    puts 'Select a person from the following list by number (not id)'
    list_people
    person_index = gets.chomp.to_i
    person = @people[person_index]
    print 'Date :'
    date_value = gets.chomp
    date = convert_date(date_value)

    rental = Rental.new(date, book, person)
    puts rental
    @rentals.push(rental)
    puts 'Rental created successfully'
  end

  def list_rentals
    puts 'Select id of any person'
    @people.each { |i| puts "id: #{i.id}, Person: #{i.name}" }
    print 'Person id: '
    person_id = gets.chomp.to_i
    @rentals.each do |i|
      puts "Date: #{i.date}, Book: '#{i.book.title}' by #{i.book.author}" if i.person.id.to_i == person_id
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [input the number]'
    select_person = gets.chomp.to_i

    case select_person
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'invalid input'
    end
  end

  def convert_date(str)
    Date.parse(str)
  end

  def back_to_menu
    puts ''
    print 'Press Enter to go back to menu '
    gets.chomp
    puts ''
  end

  private

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N] '
    permission = gets.chomp.downcase == 'y'

    student = Student.new(nil, age, name, permission)
    @people.push(student)
    puts 'Person created successfully'
    back_to_menu
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'specialization '
    specialization = gets.chomp.downcase

    teacher = Teacher.new(age, specialization, name)
    @people.push(teacher)
    puts 'Person created successfully'
    back_to_menu
  end
end
