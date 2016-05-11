class CheckController < ApplicationController

  def index
    @card_random = current_user.current_deck.cards.random if current_user.current_deck
  end

  def check
    card = Card.find(params[:card][:id])
    err_number = check_by_levenshtein( card.original_text, params[:card][:original_text] )
    result = card.correct? params[:card][:original_text]
    if result
      flash[:success] = t(:success_check)
    else
      flash[:danger] = t(:danger_check, entered_word: params[:card][:original_text], original_word: card.original_text, err_number: err_number)
    end
    card.accept_answer( SuperMemo.get_data({ err_number: err_number, internum: card.memo_count, efactor: card.efactor }))
    redirect_to check_path
  end

  private

  def check_by_levenshtein(original_word, inputed_word)
    DamerauLevenshtein.distance(original_word, inputed_word)
  end

end
