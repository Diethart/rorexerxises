class Addcolumnstocards < ActiveRecord::Migration
  def change
    add_column    :cards, :efactor,    :float, default: 2.5
    change_column :cards, :memo_count, :int,   default: 1
    remove_column :cards, :err_limit
  end
end
