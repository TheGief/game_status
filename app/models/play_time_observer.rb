class PlayTimeObserver < ActiveRecord::Observer
  
  def after_save(play_time_model)
    NotifyFriends.play_time_created(play_time_model).deliver
  end

end