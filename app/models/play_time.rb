class PlayTime < ActiveRecord::Base
  attr_accessible :start, :end, :game_id, :console_id, :user_id

  belongs_to :user

  before_create :set_duration

  # validates :start, :end, :game_id, :console_id, :user_id, :presence => true

  private

  def set_duration
    self.duration = (self.end - self.start) / 60 
  end

end
