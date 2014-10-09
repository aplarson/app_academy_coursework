class Student
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  def name
    @first_name + " " + @last_name
  end
  
  def courses
    @courses
  end
  
  def enroll(course)
    @courses << course unless @courses.include?(course) || has_conflict?(course, @courses)
  end
  
  def course_load
    @load_hash = {}
    @courses.each do |course|
      if @load_hash.has_key?(course.department)
        @load_hash[course.department] += course.credits
      else
        @load_hash[course.department] = course.credits
      end
    end
    @load_hash 
  end
  
  def has_conflict?(new_course, old_courses)
    old_courses.each do |old_course|
      return true if new_course.conflicts_with?(old_course)
    end
    false
  end
    
end

class Course
  attr_accessor :department, :credits, :time, :days
  
  def initialize(course_name, department, credits, days, time)
    @course_name = course_name
    @department =  department
    @credits = credits
    @students = []
    @days = days
    @time = time
  end
  
  def students
    @students
  end
  
  def add_student(student)
    @students << student
    student.enroll(self)
  end
  
  def conflicts_with?(other_course)
    return false unless self.time == other_course.time
    conflicts = self.days.select {|day| other_course.days.include?(day)}
    !conflicts.empty?
  end
end