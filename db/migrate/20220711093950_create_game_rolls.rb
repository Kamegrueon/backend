class CreateGameRolls < ActiveRecord::Migration[6.1]
  def change
    create_table :game_rolls do |t|
      t.references :game, foregin_key: true
      t.references :roll, foregin_key: true
      t.string :roll_name, null: false
      t.timestamps
    end
  end
end
