class Api::V1::PlayersController < ApplicationController
  def index
    player_data = Player.where(game_id: params[:game_id])
    render json: player_data
  end
end
