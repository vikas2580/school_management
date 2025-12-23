require 'rails_helper'

RSpec.describe Course, type: :model do
  let!(:admin) do
    User.new(
      email: "admin@course.com",
      password: "password123",
      password_confirmation: "password123",
      role: :admin
    ).tap { |u| u.save!(validate: false) }
  end

  let!(:school) do
    School.create!(
      name: "Bootstrap School",
      created_by: admin
    )
  end

  describe "associations" do
    it "belongs to a school" do
      assoc = described_class.reflect_on_association(:school)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it "has many batches" do
      assoc = described_class.reflect_on_association(:batches)
      expect(assoc.macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      course = Course.new(school: school)
      expect(course).to_not be_valid
    end

    it "is valid with name and school" do
      course = Course.new(
        name: "Ruby",
        school: school
      )
      expect(course).to be_valid
    end
  end
end









# # spec/models/course_spec.rb
# require 'rails_helper'

# RSpec.describe Course, type: :model do
#   let!(:bootstrap_school) do
#     School.create!(name: "Bootstrap School").tap { |s| s.update_column(:created_by_id, nil) }
#   end

#   let!(:bootstrap_admin) do
#     User.create!(
#       school: bootstrap_school,
#       email: "admin@bootstrap.com",
#       password: "password123",
#       password_confirmation: "password123",
#       role: :admin
#     ).tap { |u| u.update_column(:created_by_id, nil) }
#   end

#   it "belongs to a school" do
#     course = Course.new(school: bootstrap_school)
#     expect(course.school).to eq(bootstrap_school)
#   end

#   it "has many batches" do
#     course = create(:course, school: bootstrap_school, created_by: bootstrap_admin)
#     create_list(:batch, 3, course: course)
#     expect(course.batches.count).to eq(3)
#   end

#   it "validates presence of name" do
#     course = Course.new(school: bootstrap_school)
#     expect(course).to_not be_valid
#     expect(course.errors[:name]).to include("can't be blank")

#     course.name = "Mathematics"
#     expect(course).to be_valid
#   end
# end