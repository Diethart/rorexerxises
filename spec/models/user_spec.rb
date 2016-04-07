require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:deck) { FactoryGirl.create(:deck, user: user) }
  let!(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  describe '.get_users_with_number_of_expired_cards' do

    it 'should return 1 user with 1 card' do
    users = User.get_users_with_number_of_expired_cards.first
    expect(users[0]).to eq(user.email)
    expect(users[1]).to eq(1)
    end
  end
end
