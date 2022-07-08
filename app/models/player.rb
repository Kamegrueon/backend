class Player < ApplicationRecord
  has_many :game_player_relations, dependent: :destroy, foreign_key: 'player_id'
  has_many :games, through: :game_player_relations
  has_many :cause_of_deaths

  validates :player_name, presence: true
end