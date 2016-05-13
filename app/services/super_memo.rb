class SuperMemo

  MARKS = [5, 4, 3, 2, 2, 1]

  class << self
    attr_reader :params

    def get_data(params)
      @params = params
      params[:mark] = get_mark(params[:err_number])
      data = { review_date: next_review_date, efactor: new_efactor, memo_count: new_memo_count }
    end

    private

    def next_review_date
      params[:internum] = 1 if params[:mark] < 3
      Date.today + case params[:internum]
        when 1
          1.day
        when 2
          6.day
        else
          get_date.day
      end
    end

    def new_efactor
      efactor = params[:efactor] + (0.1 - (5 - params[:mark]) * (0.08 + (5 - params[:mark]) * 0.02))
      efactor = if efactor < 1.3
        1.3
      elsif efactor > 2.5
        2.5
      else
        efactor
      end
      efactor.round(1)
    end

    def new_memo_count
      if params[:mark] < 3
        params[:internum]
      else
        params[:internum] + 1
      end
    end

    def get_date
      ((params[:internum]-1)*params[:efactor]).round
    end

    def get_mark(err_number)
      return 0 if err_number > 5
      MARKS[err_number]
    end
  end
end
