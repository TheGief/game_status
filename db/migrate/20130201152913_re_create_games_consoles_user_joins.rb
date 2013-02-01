class ReCreateGamesConsolesUserJoins < ActiveRecord::Migration
  def up
    create_table :games_users do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end

    add_index "games_users", ["user_id", "game_id"], :name => "index_games_users_on_user_id_and_game_id"

    create_table :consoles_users do |t|
      t.integer :user_id
      t.integer :console_id

      t.timestamps
    end

    add_index "consoles_users", ["user_id", "console_id"], :name => "index_consoles_users_on_user_id_and_console_id"
  end

  def down
    drop_table :games_users
    drop_table :consoles_users
  end
end