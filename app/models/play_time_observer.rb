class PlayTimeObserver < ActiveRecord::Observer

  def after_save(play_time)
    # friends with console and game
    sender = play_time.user
    friends = sender.friends.find(
      :all,
      :joins => [:games, :consoles],
      :conditions => ["games.id = ? AND consoles.id = ?", play_time.game.id, play_time.console.id]
    )

    if play_time.notify && friends.any?
      friends.each do |friend|
        # How to do time zone for each friend?
        # Time.use_zone friend.time_zone

        # notify by email
        if friend.notify_email
          NotifyFriends.play_time_created(play_time, friend).deliver
        else
          play_time.logger.debug "Not sending E-Mail to #{friend.username}, he has it disabled"
        end

        # notify by sms
        if friend.notify_sms
          twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
          twilio_client.account.sms.messages.create(
            :from => "7076347022",
            :to => friend.phone,
            :body => "#{sender.username} is playing #{play_time.game.title} @ #{start_time}"
          )
        else
          play_time.logger.debug "Not sending SMS to #{friend.username}, he has it disabled"
        end
      end
    else
      play_time.logger.debug "Not sending notifications due to zero friends with game and console or, 'notify friends' unchecked"
    end
  end

end