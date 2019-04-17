class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'games'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    game = Game.find(data["id"])
    game.update!(hiscore: data["hiscore"])
    ActionCable.server.broadcast('games', data)
  end
end
