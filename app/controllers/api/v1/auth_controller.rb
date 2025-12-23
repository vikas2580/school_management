module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user_from_token!, only: [:login]

      def login
        user = User.find_by(email: params[:email])

        if user && user.valid_password?(params[:password])
          token = JwtService.encode(
            user_id: user.id,
            role: user.role
          )

          render json: {
            token: token,
            user: {
              id: user.id,
              email: user.email,
              role: user.role
            }
          }, status: :ok
        else
          render json: { error: 'Invalid email or password' },
                 status: :unauthorized
        end
      end
    end
  end
end
