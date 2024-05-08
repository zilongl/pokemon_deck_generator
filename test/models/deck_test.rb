require "test_helper"

class DeckTest < ActiveSupport::TestCase
  test "should not save deck without name" do
    deck = Deck.new
    assert_not deck.save, "Saved the deck without a name"
  end
  
  test "should save valid deck" do
    deck = Deck.new(name: "My First Deck")
    assert deck.save
  end
end
