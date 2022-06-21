class GamesController < ApplicationController
  def index
    games = Game.all
    render json: games
  end

  def show
    game = Game.find(params[:game_id])
  end
end
