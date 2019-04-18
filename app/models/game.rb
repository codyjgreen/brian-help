class Game < ApplicationRecord
  has_many :tiles
  has_many :players, through: :tiles

  # Randomly generate board
  def generate_board
    self.size ||= 8
    map_size = self.size * self.size
    heights = generate_tile_heights(map_size)

    # Assign heights to tiles
    (0...map_size).each do |i|
      Tile.create(game_id: self.id, index: i, height: heights[i])
    end
  end

  # Get player with current hiscore
  def leader
    self.players.order(score: :desc).first
  end

  # Get next state, return game state as a string
  # Randomly raise tiles to fill height 0
  #   Pick random tiles equal to half of tiles with height 0
  # Decrement tiles based on:
  #   If a player was on the tile
  #   Pick random tiles equal to half the number of players
  def update_next_state
    # Maybe if I do this it won't query for this game's tiles every time? ¯\_(ツ)_/¯
    tiles = self.tiles 
    players = self.players 
    voids = tiles.where("height < 1")

    # Pick random tiles to raise
    raiseTiles = voids.sample((voids.length/2).ceil)
    dropCounter = (players.length/2).ceil
    dropTiles = []

    # Drop tiles players were on
    players.each do |player|
      dropTiles << player.tile
    end 

    # Pick random tiles to drop
    while dropCounter > 0
      randTile = tiles.sample

      if (!dropTiles.include?(randTile) && randTile.height > 0)
        dropTiles << randTile 
        dropCounter -= 1
      end
    end

    tiles.each do |tile| 
      if (dropTiles.include?(tile))
        tile.update(height: tile.height-1)
      elsif (raiseTiles.include?(tile))
        tile.update(height: [2, 1, 1, 1].sample)
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
  def generate_tile_heights(map_size)
    # USE SUPER SIMPLIFIED VERSION FOR NOW
    return Array.new(map_size, 1)

    # STUFF BELOW FOR MORE COMPLEX IMPLEMENTATION IN THE FUTURE
    # I RAN OUT OF TIME :(
    tiles = [
      Array.new((map_size*0.5).floor, 1), 
      Array.new((map_size*0.4).floor, 2), 
      Array.new((map_size*0.1).floor, 3)  
    ].flatten

    # Compensate for imperfect percentage rounding 
    (map_size - tiles.size).times do |i|
      tiles.push([1, 2, 3].sample)
    end

    # Shuffle the tiles to randomly assign them
    tiles = tiles.shuffle

    return tiles
  end
end
