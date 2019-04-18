class PlayersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'players'
  end

  def unsubscribed
    # Player.find(params["player_id"]).destroy()
  end

  def receive(data)
    player = Player.find(data["id"])
    player.update!(tile_id: data["tile_id"], score: data["score"])
    ActionCable.server.broadcast('players', data)
  end
end
