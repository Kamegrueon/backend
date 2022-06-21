class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :game_name, null: false
      t.timestamps
    end
  end
end
