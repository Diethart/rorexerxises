require 'pp'

class CardsController < ApplicationController

  def index
    @cards = Deck.find(current_user.current_deck_id).cards.order('review_date') if current_user.current_deck_id
  end

  def new
  	@card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:success] = "Вы создали карточку!"
      redirect_to @card
    else
      flash[:danger] = "Вы неправильно заполнили поля!"
      redirect_to :back
    end
  end

  def show
    @card = card
    @deck_name = Deck.find(card.deck_id).name
  end

  def edit
    @card = card
  end

  def update
    card.update(card_params)
    redirect_to card
  end

  def destroy
    Card.destroy(params[:id])
    redirect_to action: 'index'
  end

  private

  def card
    current_user.current_deck.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :avatar, :deck_id)
  end
end


