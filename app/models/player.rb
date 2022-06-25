class Player < ApplicationRecord
  has_many :game_player_relations, dependent: :destroy, foreign_key: 'game_id'
  has_many :games, through: :game_player_relations
end
