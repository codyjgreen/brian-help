class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :score
      t.integer :game_id
      t.string :color

      t.timestamps
    end
  end
end
