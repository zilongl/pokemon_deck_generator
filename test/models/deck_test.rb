require "test_helper"

class DeckTest < ActiveSupport::TestCase
  test "should not save deck without name and type" do
    deck = Deck.new
    assert_not deck.save, "Saved the deck without a name and type"
  end

  test "should not save deck without name" do
    deck = Deck.new(card_type: "Fire")
    assert_not deck.save, "Saved the deck without a name"
  end

  test "should not save deck without type" do
    deck = Deck.new(name: "My First Deck")
    assert_not deck.save, "Saved the deck without a type"
  end
  
  test "should save valid deck" do
    deck = Deck.new(name: "My First Deck", card_type: "Fire")
    assert deck.save
  end
end
