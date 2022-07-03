class CreateGameRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :game_roles do |t|
      t.references :game, foregin_key: true
      t.references :role, foregin_key: true
      t.timestamps
    end
  end
end
