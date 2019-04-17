class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :score
      t.string :color
      t.integer :game_id
      t.integer :tile_id
      t.integer :tile_index

      t.timestamps
    end
  end
end
