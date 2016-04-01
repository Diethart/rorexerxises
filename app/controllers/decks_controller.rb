class DecksController < ApplicationController

  def index
    @decks = current_user.decks
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    flash[:danger] = "Вы должны ввести имя колоды!" unless @deck.save
    redirect_to action: "index"
  end

  def destroy
    current_user.current_deck_id == params[:id].to_i ? (flash[:danger] = "Нельзя удалить текущую колоду!"):(Deck.destroy(params[:id]))
    redirect_to action: "index"
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id)
  end
end
