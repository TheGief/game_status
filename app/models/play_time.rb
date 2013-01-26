class PlayTime < ActiveRecord::Base

  attr_accessible :start, :end, :game_id, :console_id, :user_id

  belongs_to :user
  belongs_to :game
  belongs_to :console

  scope :future, lambda { where("play_times.end > ?", Time.current ) }

  before_create :set_duration

  # 
  validate :dates_parseable?
  validates :start, :end, :game_id, :console_id, :presence => true

  def in_progress?
    return true if self.start < Time.current && self.end > Time.current
    return false
  end

  private

  def dates_parseable?
    errors.add(:start, "Start Time invalid, try something like '6pm' or '10:15am'") unless Chronic.parse(self.start)
    errors.add(:end, "Duration invalid, try something like '2 hrs' or '90 mins'") unless Chronic.parse(self.end)
    logger.info errors.to_yaml
  end

  def set_duration
    self.duration = (self.end - self.start) / 60 
  end

end