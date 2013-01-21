class FriendshipsController < ApplicationController
  
  def index
  end

  def req
    @user = current_user
    @friend = User.find(params[:id])
    unless @friend.nil?
      if Friendship.request(@user, @friend)
        flash[:notice] = "Friendship with #{@friend.username} requested"
      else
        flash[:notice] = "Friendship with #{@friend.username} cannot be requested"
      end
    end
    redirect_to friends_path
  end

  def accept
    @user = current_user
    @friend = User.find(params[:id])
    unless @friend.nil?
      if Friendship.accept(@user, @friend)
        flash[:notice] = "Friendship with #{@friend.username} accepted"
      else
        flash[:notice] = "Friendship with #{@friend.username} cannot be accepted"
      end
    end
    redirect_to friends_path
  end

  def reject
    @user = current_user
    @friend = User.find(params[:id])
    unless @friend.nil?
      if Friendship.reject(@user, @friend)
        flash[:notice] = "Friendship with #{@friend.username} rejected"
      else
        flash[:notice] = "Friendship with #{@friend.username} cannot be rejected"
      end
    end
    redirect_to friends_path
  end

end
