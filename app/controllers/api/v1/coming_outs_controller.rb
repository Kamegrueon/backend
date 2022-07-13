class Api::V1::ComingOutsController < ApplicationController
  def create
    coming_out = ComingOut.new(coming_out_params)
    if coming_out.save
      render json: { type: '/coming_outs'},
                     status: 200
    else
      render json: coming_out.errors
    end
  end

  private

  def coming_out_params
    params.require(:coming_out).permit(:daily_id, :player_id, :roll_name)
  end
end
