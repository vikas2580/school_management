# app/models/enrollment_request.rb
class EnrollmentRequest < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2 }

  belongs_to :user
  belongs_to :batch

  validates :user_id, uniqueness: { scope: :batch_id, message: "already requested this batch" }
end
