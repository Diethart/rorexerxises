class Card < ActiveRecord::Base
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :equal

  scope :date_check, -> {where( "review_date <= ?", Date.today )}
  scope :random, -> { date_check.order("RANDOM()").limit(1) }

  def equal
    errors.add(:original_text, "can't be the same with translated_text") if original_text.downcase == translated_text.downcase
  end

  def self.correct?(id, text)
    @card = self.find(id)
    return true if @card.original_text.downcase == text.downcase
    false
  end

  def self.renew_date(id)
    @card = self.find(id)
    @card.review_date = Date.today + 3
    @card.save
  end

end
