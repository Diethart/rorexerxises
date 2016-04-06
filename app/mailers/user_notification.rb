class UserNotification < ApplicationMailer
  default from: 'banana-sundae@heroku.com'

  def welcome_email(user)
    @user = user
    @url  = 'banana-sundae.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to Flashcardsapp!')
  end

  def self.send_notifications
    @users = User.get_users_with_number_of_expired_cards
    if @users
      @users.each do |user|
        notify_user(user[0], user[1]).deliver_now
      end
    end
  end

  def notify_user(email, count)
    @url  = 'banana-sundae.herokuapp.com'
    @cards_count = count
    mail(to: email, subject: "У вас есть непроверенные карточки!")
  end
end
