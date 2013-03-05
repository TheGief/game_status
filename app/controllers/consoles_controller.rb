class ConsolesController < ApplicationController

  def index
    @consoles = Console.find(:all, order: :title)
    @owned_consoles = current_user.consoles
  end

  def show
    @console = Console.find(params[:id])
    @own_console = current_user.consoles.exists?(params[:id])
    @friends_with_console = current_user.friends.with_console @console
  end

  def new
    @console = Console.new
  end

  def edit
    @console = Console.find(params[:id])
  end

  def create
    @console = Console.new(params[:console])
    if @console.save
      redirect_to @console, notice: 'Console was successfully created.'
    else
      render action: 'new', notice: 'Please try again'
    end
  end

  def update
    @console = Console.find(params[:id])
    if @console.update_attributes(params[:console])
      redirect_to @console, notice: 'Console was successfully updated.'
    else
      render action: 'edit', notice: 'Please try again'
    end
  end

  def destroy
    @console = Console.find(params[:id])
    @console.destroy
    redirect_to consoles_url
  end

  def add_remove
    @console = Console.find(params[:id])

    # add or remove the console from user's collection
    if current_user.consoles.exists?(@console)
      current_user.consoles.delete(@console)
    else
      current_user.consoles << @console
    end

    if request.xhr?
      render :nothing => true
    else
      redirect_to consoles_url
    end
    
  end

end