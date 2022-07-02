class Game < ApplicationRecord
  has_many :dailies
  has_many :game_player_relations, dependent: :destroy
  has_many :players, through: :game_player_relations

  validates :game_name, presence: true
end
