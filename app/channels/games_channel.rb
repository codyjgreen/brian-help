class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'games'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    game = Game.find(data["id"])
    
    if data["hiscore"] && data["hiscore"] > game.hiscore 
      game.update!(hiscore: data["hiscore"])
    end

    ActionCable.server.broadcast('games', data)
  end
end
