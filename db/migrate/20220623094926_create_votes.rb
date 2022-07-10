class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :voter, foreign_key: { to_table: :players }
      t.references :voted, foreign_key: { to_table: :players }
      t.references :daily, foreign_key: true
      t.timestamps
    end
    add_index :votes, [:daily_id, :voter_id, :voted_id], unique: true
  end
end
