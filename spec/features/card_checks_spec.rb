require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

RSpec.feature "CardChecks", type: :feature do
  given!(:card) { FactoryGirl.create(:card) }
  before(:each) do
    login_user_post("someemail@gmail.com", "1111")
  end

  scenario 'User input wrong data' do
    visit login_path

    fill_in 'user_email',    with: "text1"
    fill_in 'user_password', with: "text2"
    click_button 'Login'

    expect(page).to have_text("Неверный e-mail или пароль")
  end

  scenario 'User check(right word)' do
    visit check_path

    fill_in 'card_original_text', :with => 'text'
    click_button 'Check'

    expect(page).to have_text("Success!")
  end

  scenario 'User check(wrong word)' do
    visit check_path

    fill_in 'card_original_text', :with => 'text2'
    click_button 'Check'

    expect(page).to have_text("Danger!")
  end
end
