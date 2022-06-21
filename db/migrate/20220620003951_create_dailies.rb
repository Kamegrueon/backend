class CreateDailies < ActiveRecord::Migration[6.1]
  def change
    create_table :dailies do |t|
      t.references :game, foreign_key: true
      t.integer :date_progress, null: false
      t.timestamps
    end
  end
end
