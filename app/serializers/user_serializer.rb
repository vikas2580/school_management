class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :role

  attribute :school, if: Proc.new { |_, params| params[:current_user]&.admin? || params[:current_user]&.school_admin? } do |object|
    object.school&.name
  end
end