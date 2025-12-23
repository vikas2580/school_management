class SchoolSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :description, :created_at

  has_many :courses do |object|
    object.courses
  end

  
  attribute :total_students do |object, params|
    user = params[:current_user]
    if user&.admin? || (user&.school_admin? && object.id == user.school_id)
      object.students.count
    end
  end

  belongs_to :created_by, serializer: UserSerializer, if: Proc.new { |_, params| params[:current_user]&.admin? }
end