class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :phase
      t.integer :size
      t.integer :hiscore

      t.timestamps
    end
  end
end
