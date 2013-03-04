class SmsController < ApplicationController
  include Twilio::Sms

  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def listener
    @body = params["Body"]
    @number = params["From"][-10..-1]
    @user = User.find_by_phone @number

    case @body
    when /^me +(too?|2)$/i
      attend_playtime

    when /\b(pass|skip)\b/i
      unattend_playtime

    else
      send_sms @number, "Please say 'pass' or 'me too' to update your status"
    end

    render text: 'success'
  end

  def attend_playtime
    user_as_attendee_for_most_recent_playtime.update_attributes attending: true
  end

  def unattend_playtime
    user_as_attendee_for_most_recent_playtime.update_attributes attending: false
  end

private

  def most_recent_play_time
    PlayTime.where(user_id: @user.friends).most_recent.first
  end

  def user_as_attendee_for_most_recent_playtime
    most_recent_play_time.attendees.find_or_create_by_user_id(@user.id)
  end

end
