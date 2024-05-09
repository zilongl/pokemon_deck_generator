# app/controllers/decks_controller.rb
class DecksController < ApplicationController
  # Skip CSRF verification
  skip_before_action :verify_authenticity_token


  def index
    @decks = Deck.all
    render json: @decks
  end

  def show
    @deck = Deck.find(params[:id])
    render json: @deck, include: { cards: { only: [:id, :name, :card_type, :supertype, :external_id, :hp, :level, :image_url] } }
  end

  def create
    if params[:name].blank? || params[:card_type].blank?
      render json: { error: 'name and card_type are required' }, status: :unprocessable_entity
      return
    end

    deck_name = params[:name]
    card_type = params[:card_type]
    deck = Deck.new(name: deck_name, card_type: card_type)

    if card_type.present?
      cards = generate_deck(card_type)
      cards.map! do |card|
        Card.find_or_create_by(
          name: card['name'], 
          card_type: card['types']&.first, 
          supertype: card['supertype'], 
          external_id: card['id'], 
          image_url: card['images']['small'], 
          hp: card['hp'],
          level: card['level']
        )
      end
      deck.cards = cards
    end

    if deck.save
      render json: deck, status: :created
    else
      render json: deck.errors, status: :unprocessable_entity
    end
  end

  private

  def generate_deck(card_type)
    # total card => 60

    # 12-16 pokemon cards
    pokemon_cards = PokemonCardService.fetch_cards_by_supertype('Pokémon', card_type)
    # 10 energy cards
    energy_cards = PokemonCardService.fetch_cards_by_supertype('Energy', card_type)
    # rest trainer cards
    trainer_cards = PokemonCardService.fetch_cards_by_supertype('Trainer')

    number_of_pokemons = rand(12..16)
    number_of_energies = 10
    number_of_trainers = 60 - number_of_pokemons - number_of_energies

    selected_pokemon = select_pokemon_cards(pokemon_cards, number_of_pokemons)
    selected_energy = select_energy_cards(energy_cards, number_of_energies)
    selected_trainers = select_trainer_cards(trainer_cards, number_of_trainers)

    selected_pokemon + selected_energy + selected_trainers
  end

  def select_pokemon_cards(cards, count = 14)
    count.times.map do
      cards.sample
    end
  end

  def select_energy_cards(cards, count = 10)
    count.times.map do
      cards.sample
    end
  end

  def select_trainer_cards(cards, count = 36)
    # maximum 4 cards of same name
    max_count = 4
    result = []
    counts = Hash.new(0)

    while result.size < count
      element = cards.sample
      if counts[element['id']] < max_count
        result << element
        counts[element['id']] += 1
      end
    end

    result
  end
end
  