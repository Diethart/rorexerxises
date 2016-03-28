class Card < ActiveRecord::Base
  mount_uploader :avatar, CardAvatarUploader

  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user_id, presence: true
  validate :equal


  def self.random
    where( "review_date <= ?", Date.today).order("RANDOM()").take
  end

  def equal
    errors.add(:original_text, "can't be the same with translated_text") if original_text.downcase == translated_text.downcase
  end

  def correct?(text)
    original_text.downcase == text.downcase
  end

  def date_increase
    update(review_date: Date.today + 3)
  end

end
