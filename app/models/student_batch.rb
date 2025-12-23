class StudentBatch < ApplicationRecord
  belongs_to :user # Student
  belongs_to :batch
  
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end