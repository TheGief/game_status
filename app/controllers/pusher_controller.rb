class PusherController < ApplicationController

  skip_before_filter :authenticate_user!
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action
  protect_from_forgery :except => :user_status

  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id, # => required
        :user_info => {
          :email => current_user.email
        }
      })
      render :json => response
    else
      render :text => "Forbidden", :status => '403'
    end
  end

  def user_status
    webhook = Pusher::WebHook.new(request)
    if webhook.valid?

      webhook.events.each do |event|
        user = User.find event["user_id"]
        case event["name"]
        when 'member_added'
          user.online = true
        when 'member_removed'
          user.online = false
        end
        user.save
      end

      render text: 'ok'
    else
      render text: 'invalid', status: 401
    end
  end

end