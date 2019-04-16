class Api::PlayersController < ApplicationController
  before_action :find_player, only: [:update]
  def index
    @players = Player.all
    render json: @players
  end

  def create
    @player = Player.create
    render json: @player, status: :accepted
  end
 
  def update
    @player.update(player_params)
    if @player.save
      render json: @player, status: :accepted
    else
      render json: { errors: @player.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @player.destroy()
  end
 
  private
 
  def player_params
    params.require(:player).permit!
  end
 
  def find_player
    @player = Player.find(params[:id])
  end
end
