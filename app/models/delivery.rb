class Delivery < ApplicationRecord
  belongs_to :user, required: true

  has_many :delivery_options, dependent: :destroy

  has_many :options, through: :delivery_options, inverse_of: :delivery
  has_one :urgence, through: :delivery_options
  has_one :volume, through: :delivery_options


  has_many :pickups, dependent: :destroy
  has_many :drops, dependent: :destroy

  has_many :order_items, as: :orderable, dependent: :destroy
  has_many :delivery_books, dependent: :destroy

  accepts_nested_attributes_for :drops  
  accepts_nested_attributes_for :pickups
  accepts_nested_attributes_for :delivery_options


  monetize :price_cents

  # before_validation :add_default_options

  # after_create :send_delivery_info_to_dispatch
  private

  def add_default_options
    urgence = Option.find_by(name: 'Dans la journée')
    self.delivery_options = [urgence]
  end

  def send_delivery_info_to_dispatch
    DispatchMailer.with(delivery: self).new_delivery.deliver_now
  end

  def send_delivery_info_to_user
    UserMailer.with(delivery: self).new_delivery.deliver_now
  end
end
