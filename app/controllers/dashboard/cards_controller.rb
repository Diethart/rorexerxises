class Dashboard::CardsController < ApplicationController
  before_action :card, only: [:show, :edit, :update]

  def index
    @cards = current_user.current_deck.cards if have_current_deck?
  end

  def new
  	@new_card = Card.new if have_current_deck?
  end

  def create
    @new_card = Card.new(card_params)
    if @new_card.save
      flash[:success] = t(:success_create_card)
      redirect_to @new_card
    else
      flash[:danger] =  t(:danger_create_card)
      redirect_to :back
    end
  end

  def show
    @deck_name = Deck.find(@card.deck_id).name
  end

  def edit
  end

  def update
    @card.update(card_params)
    redirect_to @card
  end

  def destroy
    Card.destroy(params[:id])
    redirect_to action: 'index'
  end

  def photos
    @photos = FlickrPhotos.new.get_photos(12)

    respond_to do |format|
      format.html { render :layout => false}
    end
  end

  private

  def have_current_deck?
    current_user.current_deck_id
  end

  def card
    @card = current_user.current_deck.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id, :avatar, :deck_id, :remote_avatar_url)
  end
end
