class Api::V1::VotesController < ApplicationController

  def index
    vote = Vote.where(daily_id: params[:daily_id])
    render json: vote
  end

  def create
    vote = Vote.new(vote_params)
    if vote.save
      render json: vote
    else
      render json: vote.errors
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:voter_id, :voted_id).merge(daily_id: params[:daily_id])
  end
end
