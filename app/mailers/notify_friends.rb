class NotifyFriends < ActionMailer::Base
  default from: "GameStat.us <admin@gamestatus.herokuapp.com>"

  def play_time_created(sender, play_time)
    @game = play_time.game.title
    @start = play_time.start.strftime "%a %l:%M%p"

    mail(
      to: sender.friends.map(&:email),
      subject: "#{sender.username} is playing #{@game} @ #{@start}")
  end
end
