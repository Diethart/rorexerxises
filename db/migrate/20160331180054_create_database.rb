class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :original_text
      t.string :translated_text
      t.integer :user_id
      t.date :review_date
      t.string :avatar
      t.integer :deck_id

      t.timestamps null: false
    end

    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.integer :current_deck_id

      t.timestamps
    end

    add_index :users, :email, unique: true

    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :null => false

      t.timestamps
    end

    add_index :authentications, [:provider, :uid]

    create_table :decks do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
