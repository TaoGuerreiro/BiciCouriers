class Course < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :carnet, optional: true
  belongs_to :bike, required: true
  belongs_to :shopping_cart, optional: true

  has_many :drops, dependent: :destroy, inverse_of: :course
  has_many :pickups, dependent: :destroy
  accepts_nested_attributes_for :drops
  accepts_nested_attributes_for :pickups

  monetize :price_cents

  attr_accessor :email


  after_create :send_course_info_to_dispatch
  private

  def send_course_info_to_dispatch
    DispatchMailer.with(course: self).new_course.deliver_now
  end


end
