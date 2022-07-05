class Api::V1::DailyReportsController < ApplicationController

  def show
    daily_report = DailyReport.find_by(daily_id: params[:daily_id]) 
    render json: daily_report
  end

  def create
    ApplicationRecord.transaction do
      DailyReport.create!(daily_report_params)
      @daily = Daily.find(params[:daily_id])
      Daily.create!(game_id: @daily.game_id, date_progress: @daily.date_progress + 1)
    end
      render json: @daily
    rescue ActiveRecord::RecordInvalid => e
      render json: { type: '/dailies', title: e.message },
                     status: 400
  end

  def update
    daily_report = DailyReport.find_by(daily_id: params[:daily_id])
    if daily_report.update(daily_report_params)
      render json: daily_report
    else
      render json: daily_report.errors
    end
  end

  private

  def daily_report_params
    params.require(:daily_report).permit(:executed_player_id, :murdered_player_id, :perished_player_id).merge(daily_id: params[:daily_id])
  end
end
