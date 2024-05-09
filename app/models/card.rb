class Card < ApplicationRecord
  has_many :deck_cards
  has_many :decks, through: :deck_cards

  validates :name, presence: true
  validates :supertype, presence: true
  validates :external_id, presence: true, uniqueness: true
end
