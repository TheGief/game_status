class CreateUsersConsolesJoin < ActiveRecord::Migration
  def change
    create_table :consoles_users, :id => false do |t|
      t.integer :console_id
      t.integer :user_id
    end
    add_index "consoles_users", ["user_id", "console_id"], :name => "index_consoles_users_on_user_id_and_console_id"
  end
end