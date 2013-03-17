class NotifyFriends < ActionMailer::Base

  default from: "GameStat.us <admin@gamestat.us>"

  def play_time_created(play_time, friend, message_body)
    @play_time = play_time
    mail to: friend.email, subject: message_body
  end

end