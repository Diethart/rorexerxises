class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :decks, dependent: :destroy
  has_many :cards, dependent: :destroy
  belongs_to :current_deck, class_name: "Deck", foreign_key: :current_deck_id
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, format: { with: /\A[a-zA-Z0-9_\-]+\z/ }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, if: -> { new_record? || changes[:email] }, email: true, uniqueness: true

  def self.get_users_with_number_of_expired_cards
    User.includes(:cards).where('cards.review_date <= ?', DateTime.now).references(:cards).map { |user| [user.email, user.cards.length] }
  end

  def admin?
    admin
  end
end
