class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  # force_ssl

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || friends_path
  end
end
