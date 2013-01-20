class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @own_game = current_user.games.exists?(params[:id])
    @game = Game.find(params[:id])
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
    redirect_to games_url
  end

  def add
    unless current_user.games.exists?(params[:id])
      current_user.games << Game.find(params[:id])
    end
    redirect_to game_url
  end

  def remove
    current_user.games.delete(Game.find(params[:id]))
    redirect_to game_url
  end
end
