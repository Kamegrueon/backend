class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'Player'
  belongs_to :voted, class_name: 'Player'
  belongs_to :daily

  validates :voter_id, presence: true
  validates :voted_id, presence: true
end