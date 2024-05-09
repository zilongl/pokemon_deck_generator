require "test_helper"

class CardTest < ActiveSupport::TestCase
  test "should not save card without any attributes" do
    card = Card.new
    assert_not card.save, "Saved the card without any attributes"
  end

  test "should not save card without name" do
    card = Card.new(card_type: "Fire", supertype: "Pokémon", external_id: "abc-1")
    assert_not card.save, "Saved the card without a name"
  end

  test "should not save card without supertype" do
    card = Card.new(name: "Charmander", card_type: "Fire", external_id: "abc-1")
    assert_not card.save, "Saved the card without a supertype"
  end

  test "should save valid card" do
    card = Card.new(name: "Charmander", card_type: "Fire", supertype: "Pokémon", external_id: "abc-1")
    assert card.save
  end

  test "should catch if external_id is not unique" do
    card = Card.new(name: "Charmander", card_type: "Fire", supertype: "Pokémon", external_id: "abc-1")
    card.save

    card = Card.new(name: "Charmander", card_type: "Fire", supertype: "Pokémon", external_id: "abc-1")
    assert_not card.save, "Saved the card with a duplicate external_id"
  end
end
