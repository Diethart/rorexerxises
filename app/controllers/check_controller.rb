class CheckController < ApplicationController
  def index
    @card_random = Card.random
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
    redirect_to root_path
  end

end
