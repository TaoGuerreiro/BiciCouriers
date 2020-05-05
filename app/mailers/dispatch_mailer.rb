class DispatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def new_course
    @course = params[:course] # Instance variable => available in view
    mail(to: 'contact@bicicouriers.fr', subject: "Nouvelle course pour #{@course.user.company}")
    # This will render a view in `app/views/user_mailer`!
  end
end
