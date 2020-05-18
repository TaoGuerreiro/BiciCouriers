class Contact < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }
  validates :phone, presence: true, format: { with: /((\+)33|0)[1-9](\d{2}){4}/ }
  validates :message, presence: true, length: { minimum: 30 }
  attribute :nickname,  :captcha  => true

  after_create :new_contact

private

  def new_contact
    ContactMailer.with(contact: self).new_contact.deliver_now
  end


end
