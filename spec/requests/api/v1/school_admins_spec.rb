require 'rails_helper'

RSpec.describe 'School Admins API', type: :request do
  let!(:admin) do
    User.create!(
      email: "superadmin@test.com",
      password: "password123",
      password_confirmation: "password123",
      role: :admin
    )
  end

  let!(:school) do
    School.create!(
      name: "Test School",
      created_by: admin
    )
  end

  describe 'POST /api/v1/school_admins' do
    it 'fails with unauthorized when admin auth is missing' do
      post '/api/v1/school_admins',
           params: {
             user: {
               email: 'schooladmin@test.com',
               password: 'password123',
               school_id: school.id
             }
           }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
