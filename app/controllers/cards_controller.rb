require 'pp'

class CardsController < ApplicationController

  def index
    @cards = Deck.find(current_user.current_deck_id).cards.order('review_date') unless current_user.current_deck_id == nil
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
    redirect_to login_path if current_user.nil?
    @card = Deck.find(current_user.current_deck_id).cards.find(params[:id])
    @deck_name = Deck.find(@card.deck_id).name
  end

  def edit
    @card = Deck.find(current_user.current_deck_id).cards.find(params[:id])
  end

  def update
    @card = Deck.find(current_user.current_deck_id).cards.find(params[:id])
    @card.update(card_params)
    redirect_to @card
  end

  def destroy
    Card.destroy(params[:id])
    redirect_to action: 'index'
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :avatar, :deck_id)
  end



end


