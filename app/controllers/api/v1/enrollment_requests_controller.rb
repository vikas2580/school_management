module Api
  module V1
    class EnrollmentRequestsController < ApplicationController
      before_action :authenticate_user_from_token!
      before_action :require_school_admin!, only: [:update]

      
      def create
        enrollment_request = EnrollmentRequest.new(
          user: current_user,
          batch_id: params[:batch_id]
        )

        if enrollment_request.save
          render json: enrollment_request, status: :created
        else
          render json: { errors: enrollment_request.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        enrollment_request = EnrollmentRequest.find(params[:id])

        if params[:status].present? && EnrollmentRequest.statuses.keys.include?(params[:status])
          enrollment_request.update(status: params[:status])
          render json: enrollment_request
        else
          render json: { error: "Invalid status" }, status: :unprocessable_entity
        end
      end
    end
  end
end
