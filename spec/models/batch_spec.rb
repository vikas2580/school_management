require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe 'associations' do
    it 'belongs to course' do
      assoc = described_class.reflect_on_association(:course)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it 'has many enrollments' do
      assoc = described_class.reflect_on_association(:enrollments)
      expect(assoc.macro).to eq(:has_many)
    end
  end
end






# # spec/models/batch_spec.rb
# require 'rails_helper'

# RSpec.describe Batch, type: :model do
#   let!(:bootstrap_school) do
#     School.new(name: "Bootstrap School").tap do |s|
#       s.save!(validate: false)  # Bypass validation
#       s.update_column(:created_by_id, nil)
#     end
#   end

#   let!(:bootstrap_admin) do
#     User.new(
#       school: bootstrap_school,
#       email: "bootstrap@admin.com",
#       password: "password123",
#       password_confirmation: "password123",
#       role: :admin
#     ).tap do |u|
#       u.save!(validate: false)
#       u.update_column(:created_by_id, nil)
#     end
#   end

#   let(:course) do
#     Course.new(
#       name: "Mathematics",
#       school: bootstrap_school
#     ).tap do |c|
#       c.created_by = bootstrap_admin
#       c.save!
#     end
#   end

#   it "belongs to a course" do
#     batch = Batch.new(course: course)
#     expect(batch.course).to eq(course)
#   end

#   it "has many enrollments" do
#     batch = Batch.create!(course: course)

#     student1 = User.new(
#       school: bootstrap_school,
#       email: "student1@example.com",
#       password: "password123",
#       password_confirmation: "password123"
#     ).tap { |u| u.created_by = bootstrap_admin; u.save! }

#     student2 = User.new(
#       school: bootstrap_school,
#       email: "student2@example.com",
#       password: "password123",
#       password_confirmation: "password123"
#     ).tap { |u| u.created_by = bootstrap_admin; u.save! }

#     create(:enrollment_request, batch: batch, user: student1, status: :approved)
#     create(:enrollment_request, batch: batch, user: student2, status: :approved)

#     expect(batch.enrollments.count).to eq(2)
#   end

#   it "is valid with a course" do
#     batch = Batch.new(course: course)
#     expect(batch).to be_valid
#   end

#   it "is invalid without a course" do
#     batch = Batch.new
#     expect(batch).to_not be_valid
#     expect(batch.errors[:course]).to include("must exist")
#   end
# end