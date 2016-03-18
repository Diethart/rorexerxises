class CardsControllerController < ApplicationController
  def show
    @cards = Card.all
  end
end
