class Delivery < ApplicationRecord
  belongs_to :user, required: true
  has_many :delivery_options, dependent: :destroy

  has_many :pickups, dependent: :destroy
  has_many :drops, dependent: :destroy

  has_many :order_items, as: :orderable
  has_many :delivery_books

  accepts_nested_attributes_for :drops
  accepts_nested_attributes_for :pickups
  accepts_nested_attributes_for :delivery_options

  monetize :price_cents

  after_create :send_delivery_info_to_dispatch
  private

  def send_delivery_info_to_dispatch
    DispatchMailer.with(delivery: self).new_delivery.deliver_now
  end

  def send_delivery_info_to_user
    UserMailer.with(delivery: self).new_delivery.deliver_now
  end
end
