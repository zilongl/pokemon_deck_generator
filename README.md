# Pokémon Card Deck Generator

A Ruby on Rails project for generating Pokémon card decks. This project uses a PostgreSQL database and integrates with the Pokémon TCG API to fetch card data.

## Installation

before running the project, you need to have a PostgreSQL database running. Then, follow the steps below:

1. Clone the repository
2. Run `bundle install`
3. Run `rails db:create`
4. Run `rails db:migrate`
5. Run `rails db:seed`
6. Run `rails s`

## Usage
### Routes
- GET `/decks` - List all decks
- POST `/decks` - Create a new deck
- GET `/decks/:id` - Show a deck

### Example of payload to create a deck
```json
{
  "name": "Fire Deck1",
  "card_type": "Fire"
}
```

### Example of response from GET `/decks`
```json
[
    {
        "id": 1,
        "name": "Water Deck1",
        "created_at": "2024-05-09T03:22:58.774Z",
        "updated_at": "2024-05-09T03:22:58.774Z",
        "card_type": "Water"
    },
    ...
]
```

### example of response from GET `/decks/:id`
```json
{
    "id": 4,
    "name": "Fire Deck1",
    "created_at": "2024-05-09T03:45:35.812Z",
    "updated_at": "2024-05-09T03:45:35.812Z",
    "card_type": "Fire",
    "cards": [
        {
            "id": 147,
            "name": "Blaziken VMAX",
            "card_type": "Fire",
            "supertype": "Pokémon",
            "image_url": "https://images.pokemontcg.io/swsh6/201.png",
            "external_id": "swsh6-201",
            "level": null,
            "hp": "320"
        },
        ...
    ]
}
```