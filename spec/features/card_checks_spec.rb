require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

RSpec.feature "CardChecks", type: :feature do
  #let!(:user) { FactoryGirl.create(:user_with_decks) } Это старый вариант, здесь создаю без связей
  let!(:user) { FactoryGirl.create(:user) }
  let!(:deck) { FactoryGirl.create(:deck, user: user) }
  let!(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  before(:each) do
    user.update(current_deck_id: deck.id)
    login_user_post(user.email, '1111')
  end

  scenario 'User check(right word)' do
    visit check_path

    fill_in 'card_original_text', :with => 'text'
    click_button I18n.t(:check)

    expect(page).to have_text(I18n.t(:success_check))
  end

  scenario 'User check word with 2 mistakes' do
    visit check_path

    fill_in 'card_original_text', :with => 'txet2'
    click_button I18n.t(:check)

    expect(page).to have_text(I18n.t(:danger_check, attempts: 2, entered_word: "txet2", original_word: "text", err_number: 2))
  end
end
