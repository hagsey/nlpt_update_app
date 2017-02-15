class UpdatesController < ApplicationController
  before_action :current_client, except: :index

  def new
    @update = @client.updates.build
  end

  def create
    @update = @client.updates.build(update_params)
    @update.user_id = current_user.id
    @update.coach_name = current_user.full_name

    if @update.save
      flash[:success] = "New update added."
      redirect_to client_path(@client)
    else
      render 'new'
    end
  end

  def index
    @updates = Update.all
  end

  def edit
    @update = @client.updates.find(params[:id])
  end

  def update
    @update = @client.updates.find(params[:id])
    if @update.update_attributes(update_params)
      flash[:success] = "Successfully updated."
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def destroy
    @update = @client.updates.find(params[:id])
    @update.destroy
    flash[:success] = "Update deleted."
    redirect_to client_path(@client)
  end
  
  def show
  end

  private

  def update_params
    params.require(:update).permit(:comment,
                                   :health_status,
                                   :movement_limitations,
                                   :general_description,
                                   :goals,
                                   :date)
  end

  def current_client
    @client = Client.find(params[:client_id])
  end
end
