require 'rails_helper'

RSpec.describe "API::V1::Schools", type: :request do
  let(:admin)        { create(:admin_user) }
  let(:school_admin) { create(:school_admin_user) }
  let(:student)      { create(:user) }

  let(:school) { create(:school, created_by: admin) }

  describe "POST /api/v1/schools" do
    it "creates school when admin" do
      post "/api/v1/schools",
           params: { school: { name: "New School" } },
           headers: auth_headers(admin)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/schools/:id" do
    it "updates school when same school_admin" do
      school_admin.update!(school: school)

      patch "/api/v1/schools/#{school.id}",
            params: { school: { name: "Updated" } },
            headers: auth_headers(school_admin)

      expect(response).to have_http_status(:ok)
    end
  end
end
