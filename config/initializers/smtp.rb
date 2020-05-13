ActionMailer::Base.smtp_settings = {
  address: "mail.gandi.net",
  port: 587,
  domain: 'bicicouriers.fr',
  user_name: ENV['GMAIL_ADDRESS'],
  password: ENV['GMAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
