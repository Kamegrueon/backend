class Api::V1::CauseOfDeathsController < ApplicationController
  def index
    res = CauseOfDeath.select(:player_id,:cause_of_death).joins(:daily).where(dailies: {date_progress: params[:date_progress], game_id: params[:game_id]})
    render json: {
      executed_player_id: res.where(cause_of_death: '処刑').length == 0 ? nil : res.where(cause_of_death: '処刑').as_json(only: [:player_id]),
      murdered_player_id: res.where(cause_of_death: '殺害').length == 0 ? nil : res.where(cause_of_death: '殺害').as_json(only: [:player_id]),
      perished_player_id: res.where(cause_of_death: '突然死').length == 0 ? nil : res.where(cause_of_death: '突然死').as_json(only: [:player_id]),      
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
    # issue 未来の日付で殺害されているのに過去に遡って殺害すると重複して表示されてしまう
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
