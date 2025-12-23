require 'rails_helper'

RSpec.describe EnrollmentRequest, type: :model do
  let!(:school) do
    School.new(name: "Test School").tap { |s| s.save!(validate: false) }
  end

  let!(:course) do
    Course.create!(
      name: "Test Course",
      school: school
    )
  end

  let!(:batch1) { Batch.create!(course: course) }
  let!(:batch2) { Batch.create!(course: course) }

  let!(:student) do
    User.new(
      email: "student@example.com",
      password: "password123",
      password_confirmation: "password123",
      role: :student,
      school: school
    ).tap { |u| u.save!(validate: false) }
  end

  describe "associations" do
    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it "belongs to batch" do
      assoc = described_class.reflect_on_association(:batch)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end

  describe "enum status" do
    it "defaults to pending" do
      enrollment = EnrollmentRequest.new(user: student, batch: batch1)
      expect(enrollment.status).to eq("pending")
    end

    it "allows approved status" do
      enrollment = EnrollmentRequest.new(
        user: student,
        batch: batch1,
        status: :approved
      )

      expect(enrollment.approved?).to be true
    end
  end

  describe "validations" do
    it "enforces uniqueness of user per batch" do
      EnrollmentRequest.create!(
        user: student,
        batch: batch1
      )

      duplicate = EnrollmentRequest.new(
        user: student,
        batch: batch1
      )

      expect(duplicate).to_not be_valid
      expect(duplicate.errors[:user_id])
        .to include("already requested this batch")
    end

    it "allows same user to request different batches" do
      first = EnrollmentRequest.create!(
        user: student,
        batch: batch1
      )

      second = EnrollmentRequest.new(
        user: student,
        batch: batch2
      )

      expect(second).to be_valid
    end
  end
end










# # spec/models/enrollment_request_spec.rb
# require 'rails_helper'

# RSpec.describe EnrollmentRequest, type: :model do
#   let(:bootstrap_school) { create_bootstrap_school }
#   let(:course) { create(:course, school: bootstrap_school) }
#   let(:batch) { create(:batch, course: course) }
#   let(:student) { create(:user, school: bootstrap_school) }

#   it "has valid statuses" do
#     expect(EnrollmentRequest.statuses).to eq({
#       "pending" => 0, "approved" => 1, "rejected" => 2
#     })
#   end

#   it "belongs to user and batch" do
#     request = EnrollmentRequest.new(user: student, batch: batch)
#     expect(request.user).to eq(student)
#     expect(request.batch).to eq(batch)
#   end

#   it "defaults to pending" do
#     request = EnrollmentRequest.create!(user: student, batch: batch)
#     expect(request.pending?).to be true
#   end

#   it "enforces uniqueness of user per batch" do
#     EnrollmentRequest.create!(user: student, batch: batch)

#     duplicate = EnrollmentRequest.new(user: student, batch: batch)
#     expect(duplicate).to_not be_valid
#     expect(duplicate.errors[:user_id]).to include("already requested this batch")
#   end

#   it "allows multiple requests from same user to different batches" do
#     batch2 = create(:batch, course: course)
#     EnrollmentRequest.create!(user: student, batch: batch)
#     request2 = EnrollmentRequest.new(user: student, batch: batch2)

#     expect(request2).to be_valid
#   end

#   it "is invalid without user or batch" do
#     request = EnrollmentRequest.new
#     expect(request).to_not be_valid
#     expect(request.errors[:user]).to include("must exist")
#     expect(request.errors[:batch]).to include("must exist")
#   end
# end