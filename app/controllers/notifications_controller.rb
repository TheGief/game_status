class NotificationsController < ApplicationController
  def index
  end
 
  def send_text_message
    from_phone_number = "7076347022"
    to_phone_number = params[:id]
    logger.info to_phone_number

    @twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
 
    @twilio_client.account.sms.messages.create(
      :from => from_phone_number,
      :to => to_phone_number,
      :body => "This is a message. It gets sent to #{to_phone_number}"
    )
  end
end