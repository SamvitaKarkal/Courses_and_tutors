class AddUniquenessToCoursesAndTutor < ActiveRecord::Migration[7.1]
  def change
    add_index :courses, :name, unique: true
    add_index :tutors, :name, unique: true
  end
end
