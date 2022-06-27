class Api::V1::PlayersController < ApplicationController
  def index
    game = Game.find(params[:game_id])
    player_data = game.players
    render json: player_data
  end
end
