require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "CardChecks", type: :feature do
  given!(:card) { FactoryGirl.create(:card) }
  scenario 'User check(right word)' do
    visit root_path

    fill_in 'card_original_text', :with => 'text'
    click_button 'Check'

    expect(page).to have_text("Success!")
  end

  scenario 'User check(wrong word)' do
    visit root_path

    fill_in 'card_original_text', :with => 'text2'
    click_button 'Check'

    expect(page).to have_text("Danger!")
  end

end
