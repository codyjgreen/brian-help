class Api::GamesController < ApplicationController
  before_action :find_game, only: [:update]
  def index
    @games = Game.all
    render json: @games
  end

  def show
    @game = Game.find(params[:id])
    render json: @game
  end

  def create
    game = Game.create
    game.generate_board
  end
 
  def update
    @game.update(game_params)
    if @game.save
      render json: @game, status: :accepted
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @game.destroy()
  end
 
  private
 
  def game_params
    params.require(:game).permit!
  end
 
  def find_game
    @game = Game.find(params[:id])
  end
end
