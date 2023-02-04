require 'securerandom'
require './decorate'

class Person < Nameable
  attr_accessor(:name, :age)
  attr_reader(:id, :rentals)

  def initialize(name, age)
    super()
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @rentals = []
  end

  def can_use_services?
    is_of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end
