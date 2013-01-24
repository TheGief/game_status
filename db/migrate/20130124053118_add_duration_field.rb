class AddDurationField < ActiveRecord::Migration
  def change
    add_column :play_times, :duration, :integer
  end
end
