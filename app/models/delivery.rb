class Delivery < ApplicationRecord
  belongs_to :user, required: true

  has_many :delivery_options, dependent: :destroy

  has_many :options, through: :delivery_options
  # has_one :urgence, -> { where(type: 'Urgence') }, through: :delivery_options, source: :option
  # has_one :volume, -> { where(type: 'Volume') }, through: :delivery_options, source: :option

  def urgence
    if new_record?
      options.find { |option| option.is_a?(Urgence) }
    else
      options.find_by(type: 'Urgence')
    end
  end
  def volume
    if new_record?
      options.find { |option| option.is_a?(Volume) }
    else
      options.find_by(type: 'Volume')
    end
  end



  has_many :pickups, dependent: :destroy
  has_many :drops, dependent: :destroy

  has_many :order_items, as: :orderable, dependent: :destroy
  has_many :delivery_books, dependent: :destroy

  accepts_nested_attributes_for :drops
  accepts_nested_attributes_for :pickups
  accepts_nested_attributes_for :delivery_options


  monetize :price_cents
  # validates_associated :drops
  # validates_associated :pickups
  # validates_associated :volume
  # validates_associated :urgence
  # validates :drops, presence: true

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
