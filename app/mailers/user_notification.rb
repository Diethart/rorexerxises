class UserNotification < ApplicationMailer
  default from: ENV['HEROKU_MAIL']

  def welcome_email(user)
    @user = user
    @url  = ENV['HEROKU_URL']
    mail(to: @user.email, subject: t(:welcome_flashcards))
  end

  def self.send_notifications
    @users = User.get_users_with_number_of_expired_cards
    @users.each do |user|
      notify_user(user[0], user[1]).deliver_now
    end
  end

  def notify_user(email, count)
    @url  = ENV['HEROKU_URL']
    @cards_count = count
    mail(to: email, subject: t(:notify_flashcards))
  end
end
