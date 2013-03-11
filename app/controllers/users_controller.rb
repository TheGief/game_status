class UsersController < ApplicationController
  def index
    @users = User.select("users.id,username,email,friendships.status")
      .joins("LEFT JOIN friendships ON users.id = friendships.friend_id AND friendships.user_id = #{current_user.id}")
      .where("users.id != ?", current_user.id)
      .limit(50)
    @friends = @users.select {|u| u.status == 'accepted'} || {}
    @not_friends = @users.select {|u| u.status != 'accepted'} || {}
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
    @consoles = @user.consoles
    
    # Games Played
    duration_stats = Attendee.joins(:user, {:play_time => :game}).where(user_id: current_user, attending: true).group(:title).sum(:duration)
    duration_stats = duration_stats.to_a
    duration_stats.map {|row| row[1] = row[1].to_i}
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column 'string', 'Game'
    data_table.new_column 'number', 'Hours Played'
    data_table.add_rows duration_stats
    options = { width: 470, height: 250, title: 'Games Played' }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, options)
  end

  def with_game_and_console
    game_id = params[:game_id]
    console_id = params[:console_id]

    if game_id and console_id
      render json: current_user.friends.with_game(game_id).with_console(console_id).pluck(:username)
    else
      render :none
    end
  end

end
