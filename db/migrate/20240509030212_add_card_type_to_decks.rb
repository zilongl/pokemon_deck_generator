class AddCardTypeToDecks < ActiveRecord::Migration[7.1]
  def change
    add_column :decks, :card_type, :string
  end
end
