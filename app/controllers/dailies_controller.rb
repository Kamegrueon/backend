class DailiesController < ApplicationController
  def index
    dailies = Daily.all
    render json: dailies
  end
end
