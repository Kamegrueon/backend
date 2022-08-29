class Api::V1::VotesController < ApplicationController

  def index
    vote = Vote.where(daily_id: params[:daily_id])
    votes_joins = %|
      LEFT JOIN dailies
	    	ON votes.daily_id = dailies.id
      LEFT JOIN games
        ON dailies.game_id = games.id
    |
    votes_select = 'votes.id, votes.voter_id, votes.voted_id, dailies.date_progress'
    votes = Vote.joins(votes_joins).select(votes_select).where(games: { id: params[:game_id]}, dailies: {date_progress: params[:date_progress]})


    render json: votes
  end

  def create
    vote = Vote.new(vote_params)
    if vote.save
      render json: vote
    else
      render json: vote.errors
    end
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.destroy
    render json: vote
  end

  private
  def vote_params
    params.require(:vote).permit(:daily_id, :voter_id, :voted_id)
  end
end
