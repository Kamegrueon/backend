class AbilityLog < ApplicationRecord
  belongs_to :target_player, class_name: 'Player'
  belongs_to :coming_out
  belongs_to :daily
end
