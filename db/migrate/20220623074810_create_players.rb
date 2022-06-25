class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :player_name, null: false
      t.timestamps
    end
    add_index :players, :player_name, unique: true
  end
end
