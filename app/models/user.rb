class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :cards, dependent: :destroy

  validates :password, format: { with: /\A[a-zA-Z0-9_\-]+\z/ }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, if: -> { new_record? || changes[:email] }
  validates :email, uniqueness: true

end
