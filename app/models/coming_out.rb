class ComingOut < ApplicationRecord
  belongs_to :daily
  has_many :ability_logs, dependent: :destroy
end
