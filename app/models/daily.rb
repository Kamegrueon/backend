class Daily < ApplicationRecord
  belongs_to :game
  has_many :votes, dependent: :destroy
  has_many :cause_of_deaths, dependent: :destroy
end
