class UsersController < ApplicationController
  def new
    @user = User.new  
  end

  def create
    @user = User.new(params[:user])  
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    if @user.save
      flash[:notice] = 'Account created.'
      redirect_to login_path
    else
      render :new
    end
  end

  def show
  end
end
