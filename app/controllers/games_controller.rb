class GamesController < ApplicationController

  def index
    @games = Game.find(:all, order: :title)
    @owned_games = current_user.games
  end

  def show
    id = params[:id]
    @game = Game.find(id)
    @owned_games = current_user.games
    @friends_with_game = current_user.friends.with_game @game
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

    if request.xhr?
      render :nothing => true
    else
      redirect_to games_url
    end
    
  end

end
