class ClientsController < ApplicationController
  before_action :current_client, except: [:index, :new, :create]

  def new
    @client = Client.new
  end

  def show
    @updates = @client.updates
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "New client added."
      redirect_to client_url(@client)
    else
      render 'new'
    end
  end

  def search
    if params[:keywords].present?
      @keywords = params[:keywords]
      client_search_term = ClientSearchTerm.new(@keywords)
      @clients = Client.where(client_search_term.where_clause,
      client_search_term.where_args).
        order(client_search_term.order)
    else
      @clients = []
    end

    respond_to do |format|
      format.html {}
      format.json { render json: @clients }
    end
  end
  
  def index
    @clients = Client.all
    @client_count = @clients.count

    respond_to do |format|
      format.html {}
      format.json { render json: @clients }
    end
  end

  def edit
  end

  def update
    if @client.update_attributes(client_params)
      flash[:success] = "Client successfully updated."
      redirect_to client_path(@client)
    else
      render 'edit'
    end

  end

  def destroy
    @client.destroy
    flash[:success] = "Successfully deleted"
    redirect_to clients_url
  end

  private

  def client_params
    params.require(:client).permit(:first_name,
                                   :last_name,
                                   :profile_image,
                                   :date_of_birth)
  end

  def current_client
    @client = Client.find(params[:id])
  end

  def client_list

    Client.all.each_with_object([]) do |client, clients|
      obj = {}
      obj[:id] = client.id
      obj[:full_name] = client.first_name + " " + client.last_name
      obj[:updated_at] = client.updated_at
      # obj[:update_count] = client.updates.count
      clients << obj
    end
  end
end
