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
      card.error
      flash[:danger] = "Вы ошиблись! Попробуйте снова! У вас осталось #{3 - card.err_limit} попыток!"
    end
    redirect_to check_path
  end

end
