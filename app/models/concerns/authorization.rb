module Authorization
  extend ActiveSupport::Concern

  def require_admin!
    return if current_user&.admin?

    render json: { error: 'Admin access only' }, status: :forbidden
  end
end
