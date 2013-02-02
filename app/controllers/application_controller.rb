class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_filter :authenticate_user!
  around_filter :user_time_zone, :if => :current_user

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || friends_path
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

end