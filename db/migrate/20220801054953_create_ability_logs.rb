class CreateAbilityLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :ability_logs do |t|
      t.references :coming_out, foreign_key: true
      t.references :target_player, foreign_key: { to_table: :players }
      t.references :daily, foreign_key: true
      t.string :ability_result, null: false
      t.timestamps
    end
  end
end
