require_relative './nameable'
require_relative './trimmer_decorator'
require_relative './capitalize_decorator'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services
    of_age? || @parent_permission
  end

  def rent_book(date, book)
    Rental.new(date, self, book)
  end
end

person = Person.new(22, 'maximilianus')
puts person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmedperson = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmedperson.correct_name
