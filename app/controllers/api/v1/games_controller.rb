class Api::V1::GamesController < ApplicationController
  def index
    games = Game.all
    roles = Role.all
    render json: {games: games, roles: roles}
  end

  def create
    ActiveRecord::Base.transaction do
      game = GamePlayerRole.new(game_players_params)
      @game = game.save
    end
      render json: @game
    rescue ActiveRecord::RecordInvalid => e
      render json: { type: '/games', title: e.message },
                     status: 400
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
  end

  private

  def game_players_params
    params.require(:game).permit(:game_name, players: [], position_ids: [])
  end
end
