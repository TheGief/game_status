class NotifyFriends < ActionMailer::Base

  default from: "GameStat.us <admin@gamestatus.herokuapp.com>"

  def play_time_created(play_time)
    @game = play_time.game
    @start_time = play_time.start.strftime "%a %l:%M%p"
    @sender = play_time.user

    mail(
      to: @sender.friends.map(&:email),
      subject: "#{@sender.username} is playing #{@game.title} @ #{@start_time}")
  end

end