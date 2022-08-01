class Api::V1::PlayersController < ApplicationController
  def index
    dailies = Daily.where(game_id: params[:game_id]).pluck(:id).join(',')
    player_joins = %|
      LEFT JOIN game_player_relations
        ON game_player_relations.player_id = players.id
      LEFT JOIN games
        ON games.id = game_player_relations.game_id 
      LEFT JOIN dailies
        ON games.id = dailies.game_id
      LEFT JOIN (
          select cause_of_deaths.player_id, cause_of_deaths.cause_of_death, dailies.date_progress as death_date 
          from cause_of_deaths 
          left join dailies 
            on cause_of_deaths.daily_id = dailies.id 
          where daily_id in(#{dailies})
          ) as cod
        ON cod.player_id = players.id AND cod.death_date < dailies.date_progress
      LEFT JOIN (
          select coming_outs.player_id, coming_outs.roll_name, dailies.date_progress, coming_outs.id as co_id
          from coming_outs 
          left join dailies 
            on coming_outs.daily_id = dailies.id 
          where daily_id in(#{dailies}) 
          )as co
        ON co.player_id = players.id AND co.date_progress <= dailies.date_progress
      |
    
    player_select = 'players.id, player_name, dailies.date_progress, cause_of_death, death_date, co_id, roll_name'

    player_data = Player.joins(player_joins).select(player_select).where(games: { id: params[:game_id]}, dailies: {date_progress: params[:date_progress]})
    players = Player.assign_player_color(player_data)
    
    render json: players
  end
end