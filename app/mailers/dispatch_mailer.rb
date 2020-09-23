class DispatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def new_course
    @course = params[:course] # Instance variable => available in view
    mail(to: 'contact@bicicouriers.fr', subject: "Nouvelle course pour #{@course.user.email}")
    # This will render a view in `app/views/user_mailer`!
  end

  def new_payement
    @stripe = params[:stripe]
    @course = params[:course] # Instance variable => available in view
    mail(to: 'contact@bicicouriers.fr', subject: "Nouvelle Payement pour #{@course.user.email}")
    # This will render a view in `app/views/user_mailer`!
  end

  def new_simulation
    @simulation = params[:simulation] # Instance variable => available in view
    mail(to: 'contact@bicicouriers.fr', subject: "Nouvelle simulation")
    # This will render a view in `app/views/user_mailer`!
  end

  def new_paid_course
    @simulation = params[:simulation] # Instance variable => available in view
    mail(to: 'contact@bicicouriers.fr', subject: "Nouvelle course payée")
    # This will render a view in `app/views/user_mailer`!
  end
end
