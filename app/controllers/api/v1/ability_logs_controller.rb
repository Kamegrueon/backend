class Api::V1::AbilityLogsController < ApplicationController
  def create
    ability_log = AbilityLog.new(ability_log_params)    
    if ability_log.save
      render json: ability_log
    else
      render json: ability_log.errors
    end

  end

  private
  def ability_log_params
    params.require(:ability_log).permit(:target_player_id, :ability_result).merge(coming_out_id: params[:coming_out_id])
  end
end
