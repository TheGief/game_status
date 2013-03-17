class PlayTimeObserver < ActiveRecord::Observer
  include Twilio::Sms

  def after_save(play_time)

    sender  = play_time.user
    game    = play_time.game
    console = play_time.console
    friends = sender.friends.with_game(game.id).with_console(console.id)

    message = "#{sender.username} is playing #{game.title} @ #{play_time.start.strftime "%a%l:%M%p"} (#{play_time.distance_of_time}) for #{play_time.duration_in_hours_minutes}"

    if play_time.notify && friends.any?
      friends.each do |friend| # How to do time zone for each friend? : Time.use_zone friend.time_zone

        if friend.notify_email
          NotifyFriends.play_time_created(play_time, friend, message).deliver
        end

        if friend.notify_sms
          send_sms friend.phone, message
        end

      end
    end

  end
end
