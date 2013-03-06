class UsersController < ApplicationController
  def index
    @users = User.select("users.id,username,friendships.status")
      .joins("LEFT JOIN friendships ON users.id = friendships.friend_id AND friendships.user_id = #{current_user.id}")
      .limit(50)
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
    @consoles = @user.consoles
  end

  def with_game_and_console
    render json: current_user.friends.with_game(params[:game_id]).with_console(params[:console_id]).pluck(:username)
  end
end