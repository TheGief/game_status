class PlayTimesController < ApplicationController

  def new
    @play_time = PlayTime.new
  end

  def create
    @play_time = PlayTime.new(params[:play_time])
    @play_time.user_id = current_user.id
    @play_time.start = Chronic.parse(params[:play_time][:start])
    @play_time.end = Chronic.parse(params[:play_time][:end] + ' from ' + params[:play_time][:start])

    if @play_time.save
      redirect_to friends_path, notice: 'Play time was successfully created.'
    else
      render play_path, notice: 'Please try again'
    end
  end

end