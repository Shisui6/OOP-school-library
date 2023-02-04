require './person'

class Student < Person
  attr_reader :clasroom

  def initialize(name, age, parent_permission)
    super(name, age)
    @parent_permission = parent_permission
  end

  def clasroom=(clasroom)
    @classroom = clasroom
    clasroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
