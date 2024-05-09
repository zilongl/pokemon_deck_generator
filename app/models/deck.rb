class Deck < ApplicationRecord
  has_many :deck_cards
  has_many :cards, through: :deck_cards

  validates :name, presence: true
  validates :card_type, presence: true
end
