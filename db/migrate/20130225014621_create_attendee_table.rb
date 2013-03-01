class CreateAttendeeTable < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :play_time_id
      t.integer :user_id
      t.boolean :attending, :default => true
          
      t.timestamps
    end 
    
    add_index :attendees, :play_time_id
    add_index :attendees, :user_id
  end
end
