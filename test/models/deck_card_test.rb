require "test_helper"

class DeckCardTest < ActiveSupport::TestCase
  def setup
    @card = Card.create(name: "Charizard", card_type: "Fire", supertype: "Pokémon")
    @deck = Deck.create(name: "Fire Deck")
    @deck_card = DeckCard.new(deck: @deck, card: @card)
  end

  test "should be valid with valid attributes" do
    assert @deck_card.valid?, "DeckCard should be valid with valid deck and card references"
  end

  test "should not be valid without deck reference" do
    @deck_card.deck = nil
    assert_not @deck_card.valid?, "DeckCard should not be valid without a deck reference"
  end

  test "should not be valid without card reference" do
    @deck_card.card = nil
    assert_not @deck_card.valid?, "DeckCard should not be valid without a card reference"
  end

  test "should save valid deck_card" do
    assert @deck_card.save, "DeckCard should be saved successfully"
  end
end
