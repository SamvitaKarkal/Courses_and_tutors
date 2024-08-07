class Course < ApplicationRecord
  has_many :tutors, inverse_of: :course, dependent: :destroy
  accepts_nested_attributes_for :tutors, allow_destroy: true

  validates_presence_of :name, uniqueness: true
end
