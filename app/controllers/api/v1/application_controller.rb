module Api
  module V1
    class ApplicationController < ActionController::API
      include Authorization

      before_action :authenticate_user_from_token!
      attr_reader :current_user

      private

      def authenticate_user_from_token!
        auth_header = request.headers['Authorization']
        return unauthorized! unless auth_header&.start_with?('Bearer ')

        token = auth_header.split(' ').last
        payload = JwtService.decode(token)
        return unauthorized! unless payload

        @current_user = User.find_by(id: payload['user_id'])
        unauthorized! unless @current_user
      end

      def unauthorized!
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
