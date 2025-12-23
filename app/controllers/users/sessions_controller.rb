class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?  # Ensure user exists and is authenticated
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: {
          user: {
            id: resource.id,
            email: resource.email,
            role: resource.role
          },
          token: request.env['warden-jwt_auth.token']  # This gets the JWT token
        }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Invalid email or password.' },
        data: {}
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: { code: 200, message: 'Logged out successfully.' }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: "Couldn't find an active session." }
      }, status: :unauthorized
    end
  end
end