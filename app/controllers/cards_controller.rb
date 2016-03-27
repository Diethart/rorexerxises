class CardsController < ApplicationController

  def index
    @cards = Card.where('user_id = ?', current_user.id).order('review_date')
  end

  def new
  	@card = Card.new
  end

  def create
    @card = Card.create(card_params)
    redirect_to @card
  end

  def show
    @card = Card.find(params[:id])
    if current_user.nil? || @card.user_id != current_user.i
      flash[:danger] = "Доступ запрещен!"
      current_user.nil? ? (redirect_to new_user_path) : (redirect_to action: 'index')
    end
  end

  def edit
    @card = Card.find(params[:id])
    if current_user.nil? || @card.user_id != current_user.id
      flash[:danger] = "Доступ запрещен!"
      current_user.nil? ? (redirect_to new_user_path) : (redirect_to action: 'index')
    end
  end

  def update
    @card = Card.find(params[:id])
    @card.update(card_params)
    redirect_to @card
  end

  def destroy
    Card.destroy(params[:id])
    redirect_to action: 'index'
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id)
  end

end


