module Twilio
  module Sms
    def send_sms(number, body)
      client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
      client.account.sms.messages.create from: ENV['TWILIO_NUMBER'], to: number, body: body
    end
  end
end
