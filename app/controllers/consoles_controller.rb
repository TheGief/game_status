class ConsolesController < ApplicationController

  def index
    @consoles = Console.all
  end

  def show
    @console = Console.find(params[:id])
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

end
