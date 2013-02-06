class AddNotifyTypesToAccount < ActiveRecord::Migration
  def change
    add_column :users, :notify_email, :boolean, :default => true
    add_column :users, :notify_sms, :boolean, :default => true
  end
end
