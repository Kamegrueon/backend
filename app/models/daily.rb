class Daily < ApplicationRecord
  belongs_to :game
  has_many :cause_of_deaths, dependent: :destroy
end
