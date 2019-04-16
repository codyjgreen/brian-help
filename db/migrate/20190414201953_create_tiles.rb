class CreateTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :tiles do |t|
      t.integer :index
      t.integer :height
      t.integer :game_id

      t.timestamps
    end
  end
end
