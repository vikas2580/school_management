require 'rails_helper'

RSpec.describe "API::V1::Courses", type: :request do
  let(:admin)        { create(:admin_user) }
  let(:school_admin) { create(:school_admin_user) }
  let(:student)      { create(:user) }

  let(:school) { school_admin.school }

  describe "POST /api/v1/courses" do
    context "when school_admin" do
      it "creates a course successfully" do
        post "/api/v1/courses",
             params: {
               course: { name: "Ruby on Rails" }
             },
             headers: auth_headers(school_admin)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("Ruby on Rails")
        expect(json["school_id"]).to eq(school.id)
      end
    end

    context "when student" do
      it "returns forbidden" do
        post "/api/v1/courses",
             params: { course: { name: "Rails" } },
             headers: auth_headers(student)

        expect(response).to have_http_status(:forbidden)
      end
    end

    context "with invalid params" do
      it "returns unprocessable_entity" do
        post "/api/v1/courses",
             params: { course: { name: "" } },
             headers: auth_headers(school_admin)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to be_present
      end
    end

    context "when not authenticated" do
      it "returns unauthorized" do
        post "/api/v1/courses",
             params: { course: { name: "Rails" } }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
