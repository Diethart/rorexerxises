# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ActionMailer::Base.perform_deliveries = false if Rails.env.test?
Rails.application.initialize!
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
