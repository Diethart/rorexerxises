require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

RSpec.feature "Login", type: :feature do
  given!(:user) { FactoryGirl.create(:user) }

  scenario 'User login with right data' do
    visit login_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: '1111'
    click_button I18n.t(:login_session)
    expect(page).to have_text(I18n.t(:success_login))
  end

    scenario 'User login with wrong data' do
    visit login_path

    fill_in 'user_email', with: "some@gmail.com"
    fill_in 'user_password', with: "password123"
    click_button I18n.t(:login_session)

    expect(page).to have_text(I18n.t(:danger_login))
  end
end
