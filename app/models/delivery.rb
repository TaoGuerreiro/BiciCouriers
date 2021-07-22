class Delivery < ApplicationRecord
  attr_accessor :email
  attr_accessor :phone
  attr_accessor :switch

  has_many :drops, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :delivery_options, dependent: :destroy
  has_many :options, through: :delivery_options
  belongs_to :urgence
  belongs_to :volume

  validates :email, presence: true
  validates :phone, presence: true
  # validates_format_of :phone, with: /\d[0-9]\)*\z/

  validates_associated :urgence, :volume

  has_many :order_items, as: :orderable
  has_many :delivery_books
  belongs_to :user, required: true

  accepts_nested_attributes_for :pickups, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :drops, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :delivery_options, reject_if: :all_blank, allow_destroy: true

  # def urgence
  #   if new_record?
  #     options.find { |option| option.is_a?(Urgence) }
  #   else
  #     options.find_by(type: 'Urgence')
  #   end
  # end
  # def volume
  #   if new_record?
  #     options.find { |option| option.is_a?(Volume) }
  #   else
  #     options.find_by(type: 'Volume')
  #   end
  # end

  monetize :price_cents

  # after_create :send_delivery_info_to_dispatch
  private

  def send_delivery_info_to_dispatch
    DispatchMailer.with(delivery: self).new_delivery.deliver_now
  end

  def send_delivery_info_to_user
    UserMailer.with(delivery: self).new_delivery.deliver_now
  end
end
