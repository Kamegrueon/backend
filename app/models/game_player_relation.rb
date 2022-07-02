class GamePlayerRelation < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :game_id, presence: true
  validates :player_id, presence: true
end
