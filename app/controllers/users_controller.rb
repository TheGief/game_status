class UsersController < ApplicationController
  def index
    @users = User.includes(:games, :consoles).limit(30)
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
  end
end