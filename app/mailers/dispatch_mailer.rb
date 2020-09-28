class DispatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def new_course
    @stripe = params[:stripe]
    @course = params[:course]
    mail(to: 'contact@bicicouriers.fr', subject: "Nouvelle course pour #{@course.user.email}")
  end

  def new_payement
    @stripe = params[:stripe]
    @course = params[:course]
    mail(to: 'contact@bicicouriers.fr', subject: "Course reglée pour #{@course.user.email}")
  end
end
