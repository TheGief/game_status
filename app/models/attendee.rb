class Attendee < ActiveRecord::Base
  attr_accessible :play_time_id, :user_id, :attending

  belongs_to :user
  belongs_to :play_time
end
