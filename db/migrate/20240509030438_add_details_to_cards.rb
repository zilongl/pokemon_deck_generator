class AddDetailsToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :image_url, :string
    add_column :cards, :external_id, :string
    add_column :cards, :subtype, :string
    add_column :cards, :level, :string
    add_column :cards, :hp, :string
  end
end
