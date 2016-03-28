require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

RSpec.feature "Login", type: :feature do
  given!(:user) { FactoryGirl.create(:user) }

  scenario 'User login with right data' do
    visit login_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: '1111'
    click_button 'Login'

    expect(page).to have_text('Вы зашли в систему!')
  end

    scenario 'User login with wrong data' do
    visit login_path

    fill_in 'user_email', with: "some@gmail.com"
    fill_in 'user_password', with: "password123"
    click_button 'Login'

    expect(page).to have_text("Неверный e-mail или пароль")
  end
end
