class AddUsernamePhone < ActiveRecord::Migration
  def up
    add_column :users, :phone, :string
    add_column :users, :username, :string
  end

  def down
    remove_column :users, :phone
    remove_column :users, :username
  end
end
