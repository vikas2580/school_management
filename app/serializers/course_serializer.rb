class CourseSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :description

  belongs_to :school, serializer: SchoolSerializer
  has_many :batches
end