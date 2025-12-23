class BatchSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :start_date, :end_date

  belongs_to :course, serializer: CourseSerializer
  has_many :students, serializer: UserSerializer, if: Proc.new { |_, params| params[:current_user]&.school_admin? || params[:current_user]&.admin? }
end