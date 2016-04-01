class CheckController < ApplicationController

  def index
    @card_random = current_user.current_deck.cards.random if current_user.current_deck
  end

  def check
    card = Card.find(params[:card][:id])
    result = card.correct? params[:card][:original_text]
    if result
      card.date_increase
      flash[:success] = "Вы угадали!"
    else
      flash[:danger] = "Вы ошиблись! Попробуйте снова!"
    end
    redirect_to check_path
  end

end
