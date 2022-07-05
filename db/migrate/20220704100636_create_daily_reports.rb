class CreateDailyReports < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_reports do |t|
      t.references :daily, foregin_key: true
      t.references :executed_player, null: false, foreign_key: { to_table: :players }
      t.references :murdered_player, foreign_key: { to_table: :players }
      t.references :perished_player, foreign_key: { to_table: :players }
      t.timestamps
    end
  end
end
