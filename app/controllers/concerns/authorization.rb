module Authorization
  def require_admin!
    forbidden! unless current_user.admin?
  end

  def require_school_admin!
    forbidden! unless current_user.school_admin?
  end

  def require_student!
    forbidden! unless current_user.student?
  end

  def forbidden!
    render json: { error: 'Forbidden' }, status: :forbidden
  end
end
