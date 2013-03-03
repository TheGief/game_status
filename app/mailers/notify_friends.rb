class NotifyFriends < ActionMailer::Base

  default from: "GameStat.us <admin@gamestat.us>"

  def play_time_created(play_time, friend, message_body)
    sender = play_time.user
    start_time = play_time.start.strftime "%a %l:%M%p"

    mail to: friend.email, subject: message_body
  end

end