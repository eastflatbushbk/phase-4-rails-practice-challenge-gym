class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response



  def show
    client = find_client
    render json: client, methods: [:total_memberships]
  end



  private


  
  def find_client
    Client.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Client not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
