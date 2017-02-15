class UsersController < ApplicationController
  def index
    @coaches = User.all
  end

  def show
    @coach = User.find(params[:id])
    @coach_updates = @coach.updates
  end

  def destroy
    @coach = User.find(params[:id])
    @coach.destroy
    flash[:success] = "Successfully deleted"
    redirect_to coaches_url
  end
end
