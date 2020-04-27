class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :carnets, :dependent => :destroy
  has_many :courses, :dependent => :destroy
  has_many :favorite_addresses, :dependent => :destroy
end
