class Api::TilesController < ApplicationController
  before_action :find_tile, only: [:update]
  def index
    @tiles = Tile.all
    render json: @tiles
  end

  def create
    tile = Tile.create
  end
 
  def update
    @tile.update(tile_params)
    if @tile.save
      render json: @tile, status: :accepted
    else
      render json: { errors: @tile.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @tile.destroy()
  end
 
  private
 
  def tile_params
    params.require(:tile).permit!
  end
 
  def find_tile
    @tile = Tile.find(params[:id])
  end
end
