require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

RSpec.feature "DeckManage", type: :feature do
  #let!(:user) { FactoryGirl.create(:user_with_decks) } Это старый вариант, здесь создаю без связей
  let!(:user) { FactoryGirl.create(:user) }
  let!(:deck) { FactoryGirl.create(:deck, user: user) }
  let!(:second_deck) { FactoryGirl.create(:deck, user: user) }
  let!(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  before(:each) do
    user.update(current_deck_id: deck.id)
    login_user_post(user.email, '1111')
  end

  scenario 'User create deck with right data' do
    visit decks_path

    click_link 'Создать колоду'
    fill_in 'deck_name', with: "test_deck_name"
    find("input[type=submit]").click

    expect(page).to have_text("test_deck_name")
  end

  scenario 'User create deck with empty field' do
    visit decks_path

    click_link 'Создать колоду'
    find("input[type=submit]").click

    expect(page).to have_text("Вы должны ввести имя колоды!")
  end

  scenario 'User delete deck' do
    visit decks_path

    all('a', text: "Удалить колоду").last.click

    expect(page).not_to have_text(second_deck.name)
  end

  scenario 'User delete current deck' do
    visit decks_path

    all('a', text: "Удалить колоду").first.click

    expect(page).to have_text("Нельзя удалить текущую колоду!")
  end

  scenario 'User changes current deck' do
    visit decks_path

    find('a', text: "Сделать текущей").click

    expect(page).to have_text("Ваши данные изменены!")
  end

end
