

class Game < ApplicationRecord
  has_many :tiles
  has_many :players, through: :tiles

  # Randomly generate board
  def generate_board
    board_size = self.size * self.size
    heights = generate_tile_heights(board_size)

    # Create tile with a random height
    (0...board_size).each do |i|
      Tile.create(game_id: self.id, index: i, height: heights[i])
    end
  end

  # Get current board
  def board 
    self.tiles.order(index: :asc)
  end

  # Get player with current hiscore
  def leader
    self.players.order(score: :desc).first
  end

  # Get next state
  def get_next_state
    # Decrement height if tile was occupied
    self.tiles.map do |tile|
      if tile.has_player
        tile.update(height: tile.height-1)
      end
    end
  end

  # Update game phase
  def update_phase
    self.update(phase: self.phase+1)
  end
  
  # Update high score
  def update_hiscore
    curr_leader = self.get_current_score_leader
    return if (@leader == curr_leader || @leader.score == curr_leader.score)

    if (curr_leader.score > self.score)
      self.update(score: curr_leader.score)
    end
  end

  private

  # Generate tiles such that:
  #  50% of the tiles have height 1
  #  40% of the tiles have height 2
  #  10% of the tiles have height 3
  def generate_tile_heights(board_size)
    tiles = [
      Array.new((board_size*0.5).floor, 1), 
      Array.new((board_size*0.4).floor, 2), 
      Array.new((board_size*0.1).floor, 3)  
    ].flatten

    # Compensate for imperfect percentage rounding 
    (board_size - tiles.size).times do |i|
      tiles.push([1, 2, 3].sample)
    end

    # Shuffle the tiles to randomly assign them
    tiles.shuffle

    return tiles
  end
end
