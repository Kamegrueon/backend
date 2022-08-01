class CreateComingOuts < ActiveRecord::Migration[6.1]
  def change
    create_table :coming_outs do |t|
      t.references :daily, foregin_key: true
      t.references :player, foregin_key: true
      t.string :roll_name, null: false
      t.timestamps
    end
  end
end
