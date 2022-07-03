class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :game_name, null: false
      t.boolean :is_win
      t.integer :date_progress
      t.timestamps
    end
  end
end