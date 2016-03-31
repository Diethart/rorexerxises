class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :decks, dependent: :destroy
  has_one  :current_deck, -> (user){ where "id = ?", user.current_deck_id }, class_name: "Deck"
  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, format: { with: /\A[a-zA-Z0-9_\-]+\z/ }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, if: -> { new_record? || changes[:email] }
  validates :email, uniqueness: true

end
