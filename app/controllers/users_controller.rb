class UsersController < ApplicationController
  def index
    @users = User.select("users.id,username,friendships.status")
      .joins("LEFT JOIN friendships ON users.id = friendships.friend_id AND friendships.user_id = #{current_user.id}")
      .limit(50)
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
  end
end