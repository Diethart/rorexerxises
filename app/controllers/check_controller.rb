class CheckController < ApplicationController
  
  def index
    @card_random = Card.random.first
  end

  def check
    if ( @result = Card.correct?(params[:card][:id], params[:card][:original_text]) )
      Card.renew_date(params[:card][:id])
      @result
    else
      @result
    end
  end

end
