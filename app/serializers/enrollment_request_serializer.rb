class EnrollmentRequestSerializer
  include JSONAPI::Serializer

  attributes :id, :status, :created_at

  belongs_to :user, serializer: UserSerializer
  belongs_to :batch, serializer: BatchSerializer
end