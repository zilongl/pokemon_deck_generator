class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card

  validates :deck, presence: true
  validates :card, presence: true
end
