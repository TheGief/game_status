class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_filter :authenticate_user!
  around_filter :set_time_zone

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || play_path
  end

  def set_time_zone
    if user_signed_in?
      Time.use_zone(current_user.time_zone) { yield }
    else
      yield
    end
  end

end
