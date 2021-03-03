class Course < ApplicationRecord


  belongs_to :user, required: true
  belongs_to :carnet, optional: true
  # belongs_to :bike
  # belongs_to :urgence, required: true
  # belongs_to :volume, required: true
  belongs_to :shopping_cart, optional: true

  has_many :drops, dependent: :destroy, inverse_of: :course
  has_many :pickups, dependent: :destroy
  has_many :course_options, dependent: :destroy

  accepts_nested_attributes_for :drops
  accepts_nested_attributes_for :pickups
  accepts_nested_attributes_for :course_options

  # has_many :user_options, through: :user

  monetize :price_cents

  # attr_accessor :email


  after_create :send_course_info_to_dispatch
  # after_create :send_course_info_to_user
  private

  def send_course_info_to_dispatch
    DispatchMailer.with(course: self).new_course.deliver_now
  end

  def send_course_info_to_user
    UserMailer.with(course: self).new_course.deliver_now
  end


end
