class Api::V1::GamesController < ApplicationController
  def index
    games = Game.all
    render json: games
  end

  def create
    game = GamePlayer.new(game_players_params)
    if game.save
      render json: game
    else
      render json: game.errors
    end
  end

  private

  def game_players_params
    params.permit(:game_name, :player_name, :pllayer_id, :player_ids)
  end
end
