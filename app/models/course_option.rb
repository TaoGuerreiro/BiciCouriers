class CourseOption < ApplicationRecord
  belongs_to :user_option
  belongs_to :course
end
