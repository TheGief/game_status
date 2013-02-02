class AddNotifyBoolean < ActiveRecord::Migration
  def change
    add_column :play_times, :notify, :boolean
  end
end
