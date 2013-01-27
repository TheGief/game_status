class NotifyFriends < ActionMailer::Base

  default from: "GameStat.us <admin@gamestatus.herokuapp.com>"

  def play_time_created(play_time)
    @game = play_time.game
    @start_time = play_time.start.strftime "%a %l:%M%p"
    @sender = play_time.user

    # email
    mail(
      to: @sender.friends.map(&:email),
      subject: "#{@sender.username} is playing #{@game.title} @ #{@start_time}")

    # sms
    to_phone_number = play_time.user.phone
    logger.info to_phone_number

    twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
    twilio_client.account.sms.messages.create(
      :from => "7076347022",
      :to => to_phone_number,
      :body => "#{@sender.username} is playing #{@game.title} @ #{@start_time}"
    )
  end

end