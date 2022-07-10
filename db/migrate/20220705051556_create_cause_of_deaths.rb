class CreateCauseOfDeaths < ActiveRecord::Migration[6.1]
  def change
    create_table :cause_of_deaths do |t|
      t.references :player, foreign_key: true
      t.references :daily, foreign_key: true
      t.string :cause_of_death, null: false
      t.timestamps
    end
    add_index :cause_of_deaths, [:player_id, :daily_id], unique: true
  end
end
