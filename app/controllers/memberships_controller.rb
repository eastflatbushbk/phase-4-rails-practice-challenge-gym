class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response



  def create
    Membership.where(gym_id: params[:membership][:gym_id]).where(client_id: params[:membership][:client_id]).present ? 
    # membership = Membership.new(membership_params)
    membership = Membership.create(membership_params)
    render json: membership, status: :created
  end

  private

  def membership_params
    params.permit(:charge, :client_id, :gym_id)
  end
  


  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
