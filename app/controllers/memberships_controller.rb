class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response



  def create
    if
    Membership.where(gym_id: params[:membership][:gym_id]).where(client_id: params[:membership][:client_id]).present?  
        
   render json: {error:" A client can have only one membership with gym"}
    else
     membership = Membership.create(membership_params)
    render json: membership, status: :created
    end
  end

  private

  def membership_params
    params.permit(:charge, :client_id, :gym_id)
  end
  


  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
