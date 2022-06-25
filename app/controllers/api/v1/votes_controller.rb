class Api::V1::VotesController < ApplicationController
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
    params.permit(:voter_id, :voted_id, :game_id, :daily_id)
  end
end
