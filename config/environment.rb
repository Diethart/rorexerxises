# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => '83e883cd07213a',
  :password => 'c541ee436456a8',
  :address => 'mailtrap.io',
  :domain => 'mailtrap.io',
  :port => '2525',
  :authentication => :cram_md5
}
