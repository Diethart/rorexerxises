require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card)  { FactoryGirl.build(:card) }

  describe '#correct?' do

    it 'should return false' do
      expect(card.correct?("text2")).to be false
    end

    it 'should return true' do
      expect(card.correct?("teXT")).to be true
    end
  end

  describe '#equal' do

    it 'should be valid' do
      expect(card.valid?).to be true
    end

    it 'should be not_valid' do
      card.translated_text = card.original_text
      expect(card.valid?).to be false
    end
  end

  describe '#date_increase' do

    it 'should be true' do
      card.date_increase
      expect(card.review_date).to eq(Date.today + 3)
    end

    it 'should be false' do
      card.date_increase
      expect(card.review_date).not_to eq(Date.today)
    end
  end

  describe '.random' do
    let!(:card) { FactoryGirl.create(:card) }

    it 'review date should be today' do
      expect(Card.random.review_date).to eq(Date.today)
    end

    it 'shouldnt be later than today' do
      expect(Card.random.review_date).not_to be > Date.today
    end
  end

end
