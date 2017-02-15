class ClientSearchController < ApplicationController
  def index
    if params[:keywords].present?
      @keywords = params[:keywords]
      client_search_term = ClientSearchTerm.new(@keywords)
      @clients = Client.where(client_search_term.where_clause,
      client_search_term.where_args).
        order(client_search_term.order).limit(10)
    else
      @clients = []
    end

    respond_to do |format|
      format.html {}
      format.json { render json: @clients }
    end
  end
end
