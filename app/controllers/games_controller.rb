class GamesController < ApplicationController

  def index
    @games = Game.all
    @owned_games = current_user.games
  end

  def show
    id = params[:id]
    @game = Game.find(id)
    @owned_games = current_user.games
    @friends_playing = current_user.friends.find(:all, :joins => {:play_times => [:game, :user]}, 
                                                  :conditions => ["play_times.end > now() AND play_times.game_id = ?", id], 
                                                  :order => "start desc")
  end

  def new
    @game = Game.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render action: 'new', notice: 'Please try again'
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render action: 'edit', notice: 'Please try again'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  def add_remove
    @game = Game.find(params[:id])

    # add or remove the game from user's collection
    if current_user.games.exists?(@game)
      current_user.games.delete(@game)
    else
      current_user.games << @game
    end

    respond_to do |format|
      format.js
    end
    
  end

end
