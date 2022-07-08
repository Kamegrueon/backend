class CauseOfDeath < ApplicationRecord
  belongs_to :daily
  belongs_to :player
end
