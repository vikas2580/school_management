require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:school) do
    School.new(name: "Test School").tap { |s| s.save!(validate: false) }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123",
        school: school
      )

      expect(user).to be_valid
    end

    it "is invalid without email" do
      user = User.new(
        password: "password123",
        password_confirmation: "password123"
      )

      expect(user).to_not be_valid
    end

    it "is invalid without password" do
      user = User.new(
        email: "test2@example.com"
      )

      expect(user).to_not be_valid
    end
  end

  describe "enum roles" do
    it "allows admin role" do
      user = User.new(
        email: "admin@example.com",
        password: "password123",
        password_confirmation: "password123",
        role: :admin
      )

      expect(user.admin?).to be true
    end

    it "allows school_admin role" do
      user = User.new(
        email: "schooladmin@example.com",
        password: "password123",
        password_confirmation: "password123",
        role: :school_admin
      )

      expect(user.school_admin?).to be true
    end

    it "allows student role" do
      user = User.new(
        email: "student@example.com",
        password: "password123",
        password_confirmation: "password123",
        role: :student
      )

      expect(user.student?).to be true
    end
  end

  describe "default role" do
    it "sets default role as student" do
      user = User.new(
        email: "default@example.com",
        password: "password123",
        password_confirmation: "password123"
      )

      expect(user.role).to eq("student")
    end
  end

  describe "associations" do
    it "belongs to school (optional)" do
      assoc = described_class.reflect_on_association(:school)
      expect(assoc.macro).to eq(:belongs_to)
      expect(assoc.options[:optional]).to be true
    end
  end
end
