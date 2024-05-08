class Card < ApplicationRecord
  has_many :deck_cards
  has_many :decks, through: :deck_cards

  validates :name, presence: true
  validates :card_type, presence: true
  validates :supertype, presence: true
end