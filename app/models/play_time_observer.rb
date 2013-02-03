class PlayTimeObserver < ActiveRecord::Observer
  
  def after_save(play_time)
    # friends with console and game
    sender = play_time.user
    friends = sender.friends.find(
      :all, 
      :joins => [:games, :consoles], 
      :conditions => ["games.id = ? AND consoles.id = ?", play_time.game.id, play_time.console.id]
    )

    NotifyFriends.play_time_created(play_time, friends).deliver if play_time.notify && friends.any?
  end

end