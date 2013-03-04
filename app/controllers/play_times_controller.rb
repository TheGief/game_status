class PlayTimesController < ApplicationController

  def new
    @play_time = PlayTime.new
    
    # for sidebar
    @play_times = play_times
  end

  def create
    @play_time = PlayTime.new(params[:play_time])
    @play_time.user_id = current_user.id
    @play_time.attendees.build :user_id => current_user.id

    # for after create sidebar
    @play_times = play_times

    if @play_time.save
      redirect_to play_path, notice: 'Play time was successfully created.'
    else
      render action: 'new', params: params[:play_time]
    end
  end

  def attend
    @play_time = PlayTime.find params[:id]
    @attendee = @play_time.attendees.find_or_create_by_user_id(current_user.id)

    if @attendee 
      @attendee.update_attributes attending: true
      redirect_to play_path, notice: 'You have been added to the play time!'
    else
      redirect_to play_path, notice: 'Error adding to the play time.'
    end
  end

  def unattend
    @play_time = PlayTime.find params[:id]
    @attendee = @play_time.attendees.find_or_create_by_user_id(current_user.id)
    
    if @attendee.update_attributes attending: false
      redirect_to play_path, notice: 'Too bad you can\'t make it. Maybe next time.'
    else  
      redirect_to play_path, notice: 'Error removing you from play time.'
    end
  end

private

  def play_times
    me_and_my_friends = current_user.friends.to_a.push current_user
    PlayTime.future.joins(:user, :game, :console, {:attendees => :user}).where(:attendees => {user_id: me_and_my_friends}).uniq.order(:start)
  end

end
