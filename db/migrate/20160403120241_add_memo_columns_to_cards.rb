class AddMemoColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :memo_count, :integer, null: false, default: 0
    add_column :cards, :err_limit,  :integer, null: false, default: 0
    change_column :cards, :review_date, :timestamp
  end
end
