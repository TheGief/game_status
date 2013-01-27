class PlayTimesController < ApplicationController

  def new
    @play_time = PlayTime.new
    @play_times = current_user.play_times.future
  end

  def create
    @play_time = PlayTime.new(params[:play_time])
    @play_time.user_id = current_user.id
    
    @play_times = current_user.play_times.future

    if @play_time.save
      # TODO: send list of friends a notification
      NotifyFriends.play_time_created(current_user, @play_time).deliver
      redirect_to play_path, notice: 'Play time was successfully created.'
    else
      render action: 'new', params: params[:play_time]
    end
  end

end