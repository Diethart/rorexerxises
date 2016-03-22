class Card < ActiveRecord::Base
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :equal

  scope :date_check, -> {where( "review_date <= ?", Date.today)}
  scope :random, -> { date_check.order("RANDOM()").limit(1) }

  def equal
    errors.add(:original_text, "can't be the same with translated_text") if original_text.downcase == translated_text.downcase
  end

  def correct?(text)
    self.original_text.downcase == text.downcase
  end

  def date_increase
    self.update(review_date: Date.today + 3)
  end

end
