class SmsController < ApplicationController
  include Twilio::Sms

  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def listener
    @body = params["Body"]
    @number = params["From"]

    @reply = "You sent: '#{@body}' from #{@number}"
    send_sms @number, @reply
    render text: @reply
  end
end
