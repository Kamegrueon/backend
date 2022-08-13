class Daily < ApplicationRecord
  belongs_to :game
  has_many :votes, dependent: :destroy
  has_many :cause_of_deaths, dependent: :destroy
  has_many :coming_outs, dependent: :destroy
  has_many :ability_logs, dependent: :destroy
end
