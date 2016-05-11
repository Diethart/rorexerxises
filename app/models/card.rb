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

  def accept_answer(params)
    update( review_date: params[:review_date], memo_count: params[:memo_count], efactor: params[:efactor] )
  end

  private

  def date_increase
    #update(review_date: time_now + INTERVALS[memo_count])
  end

  def memo_increase
    #update(memo_count: memo_count + 1)
  end

  def time_now
    DateTime.now.beginning_of_hour
  end
end
