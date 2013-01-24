class CreateStatusTable < ActiveRecord::Migration
  def change
    create_table :play_times do |t|
      t.datetime :start, :end
      t.integer :user_id, :game_id, :console_id

      t.timestamps
    end
  end
end
