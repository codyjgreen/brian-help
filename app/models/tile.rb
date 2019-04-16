class Tile < ApplicationRecord
  belongs_to :game
  has_one :player

  # Check if player is on tile and 
  # return player if true
  def has_player
    Player.find_by(game_id: self.game_id, tile_id: self.id)
  end
end
