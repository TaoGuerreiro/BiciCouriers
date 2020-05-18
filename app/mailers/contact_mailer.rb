class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def new_contact
    @contact = params[:contact] # Instance variable => available in view
    mail(to: 'contact@bicicouriers.fr', subject: "Nouveau message du site")
    # This will render a view in `app/views/user_mailer`!
  end
end
