class Api::V1::ComingOutsController < ApplicationController

  def index
    coming_outs = AbilityLog.joins(coming_out: :daily)
      .select("ability_logs.id, coming_outs.player_id as coming_out_player_id, target_player_id, ability_result")
      .where("dailies.game_id = ? and dailies.date_progress <= ?",params[:game_id], params[:date_progress])
    render json: coming_outs
  end

  def create
    coming_out = ComingOut.new(coming_out_params)
    if coming_out.save
      render json: coming_out
    else
      render json: coming_out.errors
    end
  end

  private

  def coming_out_params
    params.require(:coming_out).permit(:daily_id, :player_id, :roll_name)
  end
end
