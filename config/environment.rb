# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :domain         => 'mail.google.com',
  :port           => 587,
  :user_name      => ENV['GOOGLE_MAIL'],
  :password       => ENV['GOOGLE_PASSWORD'],
  :authentication => :plain,
  :enable_starttls_auto => true
}
