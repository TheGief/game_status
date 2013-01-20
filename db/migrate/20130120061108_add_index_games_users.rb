class AddIndexGamesUsers < ActiveRecord::Migration
  def change
    add_index "games_users", ["user_id", "game_id"], :name => "index_games_users_on_user_id_and_game_id"
  end
end
