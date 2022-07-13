class Api::V1::GameRollsController < ApplicationController
  def index
    rolls = GameRoll.select('id,roll_id, roll_name').where(game_id: params[:game_id])
    render json: rolls
  end
end
