class PlayTimeObserver < ActiveRecord::Observer
  include Twilio::Sms

  def after_save(play_time)

    # get list friends with both console and game
    sender = play_time.user
    friends = sender.friends.find(
      :all,
      :joins => [:games, :consoles],
      :conditions => ["games.id = ? AND consoles.id = ?", play_time.game.id, play_time.console.id]
    )

    if play_time.notify && friends.any?

      message_body = "#{sender.username} is playing #{play_time.game.title} @ #{start_time}"
      debug_msg = "Not sending E-Mail to #{friend.username}, he has it disabled"

      friends.each do |friend| # How to do time zone for each friend? : Time.use_zone friend.time_zone

        if friend.notify_email
          NotifyFriends.play_time_created(play_time, friend, message_body).deliver
        else
          play_time.logger.debug debug_msg
        end

        if friend.notify_sms
          send_sms friend.phone message_body
        else
          play_time.logger.debug debug_msg
        end
      end
    else
      play_time.logger.debug "Not sending notifications due to zero friends with game and console or, 'notify friends' unchecked"
    end
  end

end