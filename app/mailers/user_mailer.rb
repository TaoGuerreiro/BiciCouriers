class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Bienvenue chez BiciCouriers !')
    # This will render a view in `app/views/user_mailer`!
  end


  def new_course
    @user = params[:user]
    @stripe = params[:stripe]
    @course = params[:course] # Instance variable => available in view
    mail(to: @user.email, subject: "Nouvelle livraisons")
    # This will render a view in `app/views/user_mailer`!
  end
end
