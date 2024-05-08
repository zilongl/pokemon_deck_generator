require "test_helper"

class CardTest < ActiveSupport::TestCase
  test "should not save card without any attributes" do
    card = Card.new
    assert_not card.save, "Saved the card without any attributes"
  end

  test "should not save card without name" do
    card = Card.new(card_type: "Fire", supertype: "Pokémon")
    assert_not card.save, "Saved the card without a name"
  end

  test "should not save card without supertype" do
    card = Card.new(name: "Charmander", card_type: "Fire")
    assert_not card.save, "Saved the card without a supertype"
  end

  test "should save valid card" do
    card = Card.new(name: "Charmander", card_type: "Fire", supertype: "Pokémon")
    assert card.save
  end
end
