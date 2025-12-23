class Course < ApplicationRecord
  belongs_to :school
  has_many :batches

  validates :name, presence: true
end