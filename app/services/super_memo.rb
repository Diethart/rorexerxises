class SuperMemo
  attr_reader :params

  MARKS = [5, 4, 3, 2, 2, 1]

  def initialize(params)
    @params = params
    params[:mark] = get_mark(params[:err_number])
  end

  def next_review_date
    params[:internum] = 1 if params[:mark] < 3
    case params[:internum]
    when 1
      Date.today + 1.day
    when 2
      Date.today + 6.day
    else
      Date.today + get_date.day
    end
  end

  def new_efactor
    efactor = params[:efactor] + (0.1 - (5 - params[:mark]) * (0.08 + (5 - params[:mark]) * 0.02))
    if efactor < 1.3
      efactor = 1.3
    elsif efactor > 2.5
      efactor = 2.5
    end
    efactor
  end

  def new_memo_count
    if params[:mark] < 3
      params[:internum]
    else
      params[:internum] + 1
    end
  end

  private

  def get_date
    ((params[:internum]-1)*params[:efactor]).round
  end

  def get_mark(err_number)
    return 0 if err_number > 5
    MARKS[err_number]
  end
end
