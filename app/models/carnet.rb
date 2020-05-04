class Carnet < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :carnet_template, required: true
  has_many :courses, :dependent => :destroy


end
