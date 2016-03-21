class CheckController < ApplicationController
  def index
    @card_random = Card.random.first
  end

  def check
    @card_checking = Card.find(params[:card][:id])
    @result = @card_checking.correct? params[:card][:original_text]
    @card_checking.update(review_date: Date.today + 3) if @result
  end

end
