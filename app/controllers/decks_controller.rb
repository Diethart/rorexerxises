class DecksController < ApplicationController

  def index
    @decks = current_user.decks
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    if @deck.save
      redirect_to action: "index"
    else
      flash[:danger] = t(:danger_deck_create)
      redirect_to action: "new"
    end
  end

  def destroy
    current_user.current_deck_id == params[:id].to_i ? ( flash[:danger] = t(:danger_deck_delete) ):(Deck.destroy(params[:id]))
    redirect_to action: "index"
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id)
  end
end
