class TilesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'tiles'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    tile = Tile.find(data["id"])
    tile.update!(height: data["height"])
    ActionCable.server.broadcast('tiles', data)
  end
end
