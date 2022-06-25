class CreateGamePlayerRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :game_player_relations do |t|
      t.references :game, foregin_key: true
      t.references :player, foregin_key: true
      t.timestamps
    end
    add_index :game_player_relations, [:game_id, :player_id], unique: true
  end
end
