class Api::V1::AbilityLogsController < ApplicationController
  def create
    ability_log = AbilityLog.new(ability_log_params)        
    if ability_log.save
      coming_outs = AbilityLog.joins(:coming_out, :daily)
      .select("ability_logs.id, player_id as coming_out_player_id, target_player_id, ability_result, dailies.date_progress")
      .where("dailies.game_id = ? and dailies.date_progress <= ?",params[:game_id], params[:date_progress])
      render json: coming_outs
    else
      render json: ability_log.errors
    end

  end

  private
  def ability_log_params
    params.require(:ability_log).permit(:target_player_id, :ability_result, :daily_id).merge(coming_out_id: params[:coming_out_id])
  end
end
