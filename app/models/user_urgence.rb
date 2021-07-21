class UserUrgence < ApplicationRecord
  belongs_to :user
  belongs_to :urgence
end
