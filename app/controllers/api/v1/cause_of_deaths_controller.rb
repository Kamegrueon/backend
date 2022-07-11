class Api::V1::CauseOfDeathsController < ApplicationController
  def index
    executed = CauseOfDeath.select(:player_id).find_by(daily_id: params[:daily_id], cause_of_death: '処刑')
    murdered = CauseOfDeath.select(:player_id).find_by(daily_id: params[:daily_id], cause_of_death: '殺害')
    perished = CauseOfDeath.select(:player_id).find_by(daily_id: params[:daily_id], cause_of_death: '突然死')
    render json: {
      executed_player_id: executed.nil? ? nil : executed[:player_id],
      murdered_player_id: murdered.nil? ? nil : murdered[:player_id],
      perished_player_id: perished.nil? ? nil : perished[:player_id],
    }
  end

  def create
    ApplicationRecord.transaction do
      daily = Daily.find(params[:daily_id])
      @newDaily = Daily.create!(game_id: daily.game_id, date_progress: daily.date_progress + 1)
      CauseOfDeath.create!(player_id: cod_params[:executed_player_id], daily_id: params[:daily_id], cause_of_death: '処刑')
      unless cod_params[:murdered_player_id].nil?
        CauseOfDeath.create!(player_id: cod_params[:murdered_player_id], daily_id: params[:daily_id], cause_of_death: '殺害') 
      end
      unless cod_params[:perished_player_id].nil?
        CauseOfDeath.create!(player_id: cod_params[:perished_player_id], daily_id: params[:daily_id], cause_of_death: '突然死') 
      end
    end
      render json: @newDaily
    rescue ActiveRecord::RecordInvalid => e
      render json: { type: '/dailies', title: e.message },
                      status: 400
  end

  def update
    ApplicationRecord.transaction do
      executed = CauseOfDeath.find_by(daily_id: params[:daily_id], cause_of_death: '処刑')
      executed.update(player_id: cod_params[:executed_player_id], daily_id: params[:daily_id], cause_of_death: '処刑')      
      unless CauseOfDeath.find_by(daily_id: params[:daily_id], cause_of_death: '殺害').nil?
        murdered = CauseOfDeath.find_by(daily_id: params[:daily_id], cause_of_death: '殺害')
        if cod_params[:murdered_player_id].nil?
          murdered.destroy
        else
          murdered.update(player_id: cod_params[:murdered_player_id], daily_id: params[:daily_id], cause_of_death: '殺害')
        end
      else
        unless cod_params[:murdered_player_id].nil?
          CauseOfDeath.create!(player_id: cod_params[:murdered_player_id], daily_id: params[:daily_id], cause_of_death: '殺害')
        end
      end
      unless CauseOfDeath.find_by(daily_id: params[:daily_id], cause_of_death: '突然死').nil?
        perished = CauseOfDeath.find_by(daily_id: params[:daily_id], cause_of_death: '突然死')
        if cod_params[:perished_player_id].nil?
          perished.destroy
        else
          perished.update(player_id: cod_params[:perished_player_id], daily_id: params[:daily_id], cause_of_death: '突然死')
        end
      else
        unless cod_params[:perished_player_id].nil?
          CauseOfDeath.create!(player_id: cod_params[:perished_player_id], daily_id: params[:daily_id], cause_of_death: '突然死')
        end
      end
    end
      render json: { type: '/dailies'},
                     status: 200
    rescue ActiveRecord::RecordInvalid => e
      render json: { type: '/dailies', title: e.message },
                      status: 400
  end

  private

  def cod_params
    params.require(:cod).permit(:executed_player_id, :murdered_player_id, :perished_player_id).merge(daily_id: params[:daily_id])    
  end  
end
