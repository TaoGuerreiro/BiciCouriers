class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :carnets, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :shopping_carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_one :user_facturation, dependent: :destroy


  after_create :send_welcome_email
  after_create :create_facturation_infos

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def create_facturation_infos
    UserFacturation.create(
      {
        user_id: self.id
      }
    )
  end
end
