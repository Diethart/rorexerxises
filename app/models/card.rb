class Card < ActiveRecord::Base
	validates :original_text, presence: true
	validates :translated_text, presence: true
	validates :review_date, presence: true
	validate :equal

	def equal
	  errors.add(:original_text, "can't be the same with translated_text") if original_text.downcase == translated_text.downcase
	end
end
