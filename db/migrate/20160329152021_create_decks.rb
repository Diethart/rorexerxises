class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end

    add_column :cards, :deck_id, :integer

    add_column :users, :current_deck_id, :integer
  end
end
