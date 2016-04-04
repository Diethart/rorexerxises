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

  def date_increase
    self.review_date = time_now + INTERVALS[memo_count]
    self.memo_count += 1 if memo_count < 4
    save
    self
  end

  def error
    self.err_limit += 1
    self.err_limit, self.memo_count = 0, 0 if err_limit == 3
    save
    self
  end

  def self.intervals(index)
    INTERVALS[index]
  end

  private

  def time_now
    DateTime.now.beginning_of_hour
  end
end
