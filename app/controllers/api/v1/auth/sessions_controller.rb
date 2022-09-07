class Api::V1::Auth::SessionsController < ApplicationController
  def index                
    if current_api_v1_user
      render json: { is_login: true, data: current_api_v1_user }
    else
      render json: { is_login: false, message: "ユーザーが存在しません" }
    end
  end

  private
  def sign_in_params
    params.require(:session).permit(:email, :password)
  end
end
