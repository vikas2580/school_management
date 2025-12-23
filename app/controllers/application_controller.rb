class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    decoded = JwtService.decode(token) rescue nil
    @current_user = User.find_by(id: decoded['user_id']) if decoded

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def require_student!
    render json: { error: "Forbidden" }, status: :forbidden unless current_user&.role == "student"
  end

  def require_school_admin!
    render json: { error: "Forbidden" }, status: :forbidden unless current_user&.role == "school_admin"
  end
end
