require 'rails_helper'

RSpec.describe School, type: :model do
  let!(:admin_user) do
    User.new(
      email: "admin@school.com",
      password: "password123",
      password_confirmation: "password123",
      role: :admin
    ).tap { |u| u.save!(validate: false) }
  end

  describe "associations" do
    it "belongs to created_by (User)" do
      assoc = described_class.reflect_on_association(:created_by)
      expect(assoc.macro).to eq(:belongs_to)
      expect(assoc.options[:class_name]).to eq("User")
    end

    it "has many courses" do
      assoc = described_class.reflect_on_association(:courses)
      expect(assoc.macro).to eq(:has_many)
    end

    it "has many users" do
      assoc = described_class.reflect_on_association(:users)
      expect(assoc.macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "is invalid without a name" do
      school = School.new(created_by: admin_user)
      expect(school).to_not be_valid
      expect(school.errors[:name]).to include("can't be blank")
    end

    it "is valid with name and created_by" do
      school = School.new(
        name: "Test School",
        created_by: admin_user
      )

      expect(school).to be_valid
    end
  end
end








# # spec/models/school_spec.rb
# require 'rails_helper'

# RSpec.describe School, type: :model do
#   let(:global_admin) { create_bootstrap_admin }

#   it "belongs to created_by (User)" do
#     school = School.new(name: "Test School", created_by: global_admin)
#     expect(school.created_by).to eq(global_admin)
#   end

#   it "has many courses" do
#     school = create(:school, created_by: global_admin)
#     create_list(:course, 2, school: school)
#     expect(school.courses.count).to eq(2)
#   end

#   it "has many users" do
#     school = create(:school, created_by: global_admin)
#     create_list(:user, 3, school: school, created_by: global_admin)
#     expect(school.users.count).to eq(3)
#   end

#   it "validates presence of name" do
#     school = School.new(created_by: global_admin)
#     expect(school).to_not be_valid
#     expect(school.errors[:name]).to include("can't be blank")

#     school.name = "Valid School"
#     expect(school).to be_valid
#   end

#   it "is valid with name and created_by" do
#     school = School.new(name: "Good School", created_by: global_admin)
#     expect(school).to be_valid
#   end

#   it "is invalid without created_by" do
#     school = School.new(name: "Orphan School")
#     expect(school).to_not be_valid
#     expect(school.errors[:created_by]).to include("must exist")
#   end
# end