class Api::V1::ComingOutsController < ApplicationController

  def index
    coming_outs = ComingOut.joins(:daily)
      .select("coming_outs.id, player_id")
      .where("dailies.game_id = ? and date_progress <= ?",params[:game_id], params[:date_progress])
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
