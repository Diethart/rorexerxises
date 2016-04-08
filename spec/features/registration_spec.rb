require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

RSpec.feature "Registration", type: :feature do
  scenario 'User input correct data' do
    visit new_user_path

    fill_in 'user_email', with: "email@gmail.com"
    fill_in 'user_password', with: "11111"
    fill_in 'user_password_confirmation', with: "11111"
    click_button I18n.t(:user_create)

    expect(page).to have_text(I18n.t(:success_login))
  end

    scenario 'User input incorrect data' do
    visit new_user_path

    fill_in 'user_email',                 with: "email@gmail.com"
    fill_in 'user_password',              with: "12345"
    fill_in 'user_password_confirmation', with: "11111"
    click_button I18n.t(:user_create)

    expect(page).to have_text("doesn't match Password")
  end
end
