class Daily < ApplicationRecord
  belongs_to :game

  has_one :daily_reports, dependent: :destroy
end
