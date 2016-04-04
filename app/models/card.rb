class Card < ActiveRecord::Base
  mount_uploader :avatar, CardAvatarUploader

  belongs_to :deck
  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user_id, presence: true
  validate :equal

  INTERVALS = [12.hours, 3.day, 1.week, 2.week, 1.month]


  def self.random
    where( "review_date <= ?", DateTime.now.beginning_of_hour).order("RANDOM()").take
  end

  def equal
    errors.add(:original_text, "can't be the same with translated_text") if original_text.downcase == translated_text.downcase
  end

  def correct?(text)
    original_text.downcase == text.downcase
  end

  def right_answer
    date_increase
    memo_increase
  end

  def wrong_answer
    error
    update(memo_count: 0, err_limit: 0) if err_limit == 3
  end

  def self.intervals(index)
    INTERVALS[index]
  end

  private

  def date_increase
    update(review_date: time_now + INTERVALS[memo_count])
  end

  def memo_increase
    update(memo_count: memo_count + 1) if memo_count < 4
  end

  def error
    update(err_limit: err_limit + 1) if err_limit < 3
  end

  def time_now
    DateTime.now.beginning_of_hour
  end
end
