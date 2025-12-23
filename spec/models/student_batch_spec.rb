require 'rails_helper'

RSpec.describe StudentBatch, type: :model do
  let!(:school) do
    School.new(name: "Test School").tap { |s| s.save!(validate: false) }
  end

  let!(:course) do
    Course.create!(
      name: "Test Course",
      school: school
    )
  end

  let!(:batch) { Batch.create!(course: course) }

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

  describe "validations" do
    it "is valid with progress between 0 and 100" do
      record = StudentBatch.new(
        user: student,
        batch: batch,
        progress: 50
      )

      expect(record).to be_valid
    end

    it "is invalid with progress less than 0" do
      record = StudentBatch.new(
        user: student,
        batch: batch,
        progress: -10
      )

      expect(record).to_not be_valid
      expect(record.errors[:progress]).to include("must be greater than or equal to 0")
    end

    it "is invalid with progress greater than 100" do
      record = StudentBatch.new(
        user: student,
        batch: batch,
        progress: 150
      )

      expect(record).to_not be_valid
      expect(record.errors[:progress]).to include("must be less than or equal to 100")
    end
  end
end
