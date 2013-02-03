class NotifyFriends < ActionMailer::Base

  default from: "GameStat.us <admin@gamestat.us>"

  def play_time_created(play_time, friends)
    
    sender = play_time.user
    start_time = play_time.start.strftime "%a %l:%M%p"

    # send notifications to friends
    friends.each do |friend|

      # How to do time zone for each friend?
      # Time.use_zone friend.time_zone

      # email
      mail(
        to: friend.email,
        subject: "#{sender.username} is playing #{play_time.game.title} @ #{start_time}"
      )

      # sms
      twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
      twilio_client.account.sms.messages.create(
        :from => "7076347022",
        :to => friend.phone,
        :body => "#{sender.username} is playing #{play_time.game.title} @ #{start_time}"
      )
    end
  end

end