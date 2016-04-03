class Card < ActiveRecord::Base
  mount_uploader :avatar, CardAvatarUploader

  belongs_to :deck
  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user_id, presence: true
  validate :equal


  def self.random
    where( "review_date <= ?", DateTime.now.beginning_of_hour).order("RANDOM()").take
  end

  def equal
    errors.add(:original_text, "can't be the same with translated_text") if original_text.downcase == translated_text.downcase
  end

  def correct?(text)
    original_text.downcase == text.downcase
  end

  def date_increase
    case memo_count
    when 0
      update( review_date: time_now + 12.hour, memo_count: 1 )
    when 1
      update( review_date: time_now + 3.day,   memo_count: 2 )
    when 2
      update( review_date: time_now + 1.week,  memo_count: 3 )
    when 3
      update( review_date: time_now + 2.week,  memo_count: 4 )
    when 4
      update( review_date: time_now + 1.month )
    end
    self
  end

  def error
    update( err_limit: err_limit + 1)
    update( err_limit: 0, memo_count: 0 ) if err_limit == 3
    self
  end

  private

  def time_now
    DateTime.now.beginning_of_hour
  end
end
