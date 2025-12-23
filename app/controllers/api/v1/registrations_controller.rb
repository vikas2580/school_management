module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :authenticate_user_from_token!, only: :create

      def create
        user = User.new(user_params)
        if user.save
          token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base, 'HS256')
          render json: {
            message: "Signup successful",
            user: { id: user.id, email: user.email, role: user.role },
            token: token
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :school_id)
      end
    end
  end
end