require 'pp'

class CardsController < ApplicationController

  def index
    @cards = current_user.cards.order('review_date')
  end

  def new
  	@card = Card.new
  end

  def create
    @card = Card.create(card_params)
    redirect_to @card
  end

  def show
    @card = current_user.cards.find(params[:id])
  end

  def edit
    @card = current_user.cards.find(params[:id])
  end

  def update
    @card = current_user.cards.find(params[:id])
    @card.update(card_params)
    redirect_to @card
  end

  def destroy
    Card.destroy(params[:id])
    redirect_to action: 'index'
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :avatar)
  end

end


