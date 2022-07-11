class Api::V1::PlayersController < ApplicationController
  def index
    player_joins = %|
      LEFT JOIN game_player_relations
        ON game_player_relations.player_id = players.id
      LEFT JOIN games
        ON games.id = game_player_relations.game_id 
      LEFT JOIN dailies
        ON games.id = dailies.game_id
      LEFT JOIN (select cause_of_deaths.player_id,cause_of_deaths.cause_of_death, dailies.date_progress from cause_of_deaths left join dailies on cause_of_deaths.daily_id = dailies.id) as cod
          ON cod.player_id = players.id AND cod.date_progress < dailies.date_progress
      |
    
    player_select = 'players.id, player_name, dailies.date_progress, cause_of_death'

    player_data = Player.joins(player_joins).select(player_select).where(games: { id: params[:game_id]}, dailies: {date_progress: params[:date_progress]})
    
    render json: player_data
  end
end