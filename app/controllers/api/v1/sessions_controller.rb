module Api
  module V1
    class SessionsController < Api::V1::ApplicationController
      skip_before_action :authenticate_user_from_token!, only: :create

      def create
        user = User.find_by(email: params[:email]&.downcase&.strip)
        if user&.valid_password?(params[:password])
          token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base, 'HS256')
          render json: {
            message: "Login successful",
            user: { id: user.id, email: user.email, role: user.role },
            token: token
          }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      private

      def encode_token(payload)
        JWT.encode(payload, Rails.application.secret_key_base)
      end
    end
  end
end