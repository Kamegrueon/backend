class RemoveIsWinFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :is_win, :boolean
    remove_column :games, :date_progress, :integer
  end
end
