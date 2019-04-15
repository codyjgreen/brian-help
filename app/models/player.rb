class Player < ApplicationRecord
  belongs_to :game
  has_one :tile
end
