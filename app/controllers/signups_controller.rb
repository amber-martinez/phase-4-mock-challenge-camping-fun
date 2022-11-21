class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_validation_errors

    def index
        signups = Signup.all 
        render json: signups
    end

    def create
        signup = Signup.create!(signup_params)
        render json: signup
    end

    private

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_validation_errors(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: { error: 'Camper not found' }, status: :not_found
    end

end
