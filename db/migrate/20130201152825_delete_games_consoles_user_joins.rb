class DeleteGamesConsolesUserJoins < ActiveRecord::Migration
  def up
    drop_table :games_users
    drop_table :consoles_users
  end
end