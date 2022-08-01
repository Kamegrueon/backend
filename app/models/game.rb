class Game < ApplicationRecord
  has_many :dailies, dependent: :destroy
  has_many :game_player_relations, dependent: :destroy
  has_many :players, through: :game_player_relations
  
  has_many :game_rolls, dependent: :destroy
  has_many :rolls, through: :game_rolls

  validates :game_name, presence: true
end
