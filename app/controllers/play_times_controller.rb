class PlayTimesController < ApplicationController

  def new
    @play_time = PlayTime.new
    @play_times = current_user.play_times.future
  end

  def create
    @play_time = PlayTime.new(params[:play_time])
    @play_time.user_id = current_user.id
    @play_time.start = Chronic.parse(params[:play_time][:start])
    @play_time.end = Chronic.parse(params[:play_time][:end] + ' from ' + params[:play_time][:start])

    @play_times = current_user.play_times.future

    if @play_time.save
      redirect_to play_path, notice: 'Play time was successfully created.'
    else
      render action: 'new', params: params[:play_time]
    end
  end

end