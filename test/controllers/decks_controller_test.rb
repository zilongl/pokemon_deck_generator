require 'test_helper'

class DecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deck = decks(:one)
  end

  test "should get index" do
    get decks_url
    assert_response :success
  end

  test "should show deck" do
    get deck_url(@deck)
    assert_response :success
  end

  test "deck should have 60 cards, 12-16 pokemon cards, 10 energy cards and trainer cards" do
    type = "Fire"
    post decks_url, params: { name: "Test Deck", card_type: type }

    assert_response :created

    deck = Deck.last
    assert_equal 60, deck.cards.count

    pokemon_cards = deck.cards.select { |card| card.supertype == "Pokémon" }
    assert pokemon_cards.count >= 12
    assert pokemon_cards.count <= 16

    pokemon_cards.each do |card|
      assert_equal (card.card_type.include? type), true
    end

    energy_cards = deck.cards.select { |card| card.supertype == "Energy" }
    assert_equal 10, energy_cards.count
    energy_cards.each do |card|
      assert_equal (card.name.include? type), true
    end

    trainer_cards = deck.cards.select { |card| card.supertype == "Trainer" }
    assert_equal 60 - pokemon_cards.count - energy_cards.count, trainer_cards.count
  end

  test "should return error for missing card_type" do
    post decks_url, params: { name: "Test Deck" }
    assert_response :unprocessable_entity
  end
end
