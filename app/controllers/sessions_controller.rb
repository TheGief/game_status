class SessionsController < ApplicationController

  def new
    # redirect if already logged in
    if logged_in?
      redirect_to root_url
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cleanup_old_sessions
      redirect_to games_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
  def cleanup_old_sessions
    # Sessions inactive for 24hrs are deleted
    ActiveRecord::SessionStore::Session.delete_all(["updated_at < ?", 24.hours.ago])
  end
end