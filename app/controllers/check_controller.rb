class CheckController < ApplicationController
  def index
    @card_random = Card.random.first
  end

  def check
    @card_checking = Card.find(params[:card][:id])
    @result = @card_checking.correct? params[:card][:original_text]
    @card_checking.date_increase if @result
  end

end
