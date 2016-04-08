class CheckController < ApplicationController

  def index
    @card_random = current_user.current_deck.cards.random if current_user.current_deck
  end

  def check
    card = Card.find(params[:card][:id])
    result = card.correct? params[:card][:original_text]
    if result
      card.right_answer
      flash[:success] = t(:success_check)
    else
      card.wrong_answer
      err_number = check_by_levenshtein(card.original_text, params[:card][:original_text])
      flash[:danger] = t(:danger_check, attempts: 3 - card.err_limit, entered_word: params[:card][:original_text], original_word: card.original_text, err_number: err_number)
    end
    redirect_to check_path
  end

  private

  def check_by_levenshtein(original_word, inputed_word)
    DamerauLevenshtein.distance(original_word, inputed_word)
  end

end
