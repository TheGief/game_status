class PlayTime < ActiveRecord::Base

  attr_accessible :start_time, :duration_text, :game_id, :console_id, :user_id
  attr_writer :start_time
  attr_writer :duration_text

  belongs_to :user
  belongs_to :game
  belongs_to :console

  scope :future, lambda { where("play_times.end > ?", Time.current) }

  validates :game_id, :console_id, :presence => true
  validate :check_start_time, :check_duration_text

  before_save :save_start_time, :save_duration_text
  before_create :set_duration, :set_user_id

  # start_time virtual attribute
  def start_time
    @start_time || Chronic.parse(self.start)
  end

  def save_start_time
    self.start = Chronic.parse(@start_time) if @start_time.present?
  end

  def check_start_time
    logger.info @start_time.to_yaml
    logger.info @duration_text.to_yaml
    if !@start_time.present?
      errors.add "Start time", "(at) is required"
    elsif @start_time.present? && Chronic.parse(@start_time).nil?
      errors.add "Start time", "invalid, try something like '6pm' or '10:15am'"
    end
  rescue ArgumentError
    errors.add "Start time", "is out of range"
  end

  # duration_text virtual attribute
  def duration_text
    @duration_text || ""
  end

  def save_duration_text
    self.end = Chronic.parse(@duration_text + " from " + @start_time) if @duration_text.present?
  end

  def check_duration_text
    logger.info @start_time.to_yaml
    logger.info @duration_text + " from " + @start_time
    if !@duration_text.present?
      errors.add "Duration", "(for) is required"
    elsif @duration_text.present? && Chronic.parse(@duration_text + " from " + @start_time).nil?
      errors.add "Duration", "invalid, try something like '2 hrs' or '90 mins'"
    end
  rescue ArgumentError
    errors.add "Duration", "is out of range"
  end


  def in_progress?
    return true if self.start < Time.current && self.end > Time.current
    return false
  end

  private

  def set_duration
    self.duration = (self.end - self.start) / 60 
  end

end