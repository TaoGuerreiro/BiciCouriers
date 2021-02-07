class CourseOption < ApplicationRecord
has_many :user_options
belongs_to :course

end
