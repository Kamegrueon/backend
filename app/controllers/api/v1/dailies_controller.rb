class Api::V1::DailiesController < ApplicationController
  def index
    dailies_data = Daily.select(:id, :date_progress).where(game_id: params[:game_id])
    render json: dailies_data
  end
end