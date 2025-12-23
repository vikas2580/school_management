require 'rails_helper'

RSpec.describe "API::V1::Batches", type: :request do
  let(:admin)        { create(:admin_user) }
  let(:school_admin) { create(:school_admin_user) }
  let(:student)      { create(:user) }

  let(:school) { school_admin.school }
  let(:course) { create(:course, school: school) }

  describe "POST /api/v1/batches" do
    context "when school_admin" do
      it "creates a batch successfully" do
        post "/api/v1/batches",
             params: {
               batch: {
                 name: "Batch A",
                 course_id: course.id
               }
             },
             headers: auth_headers(school_admin)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("Batch A")
        expect(json["course_id"]).to eq(course.id)
      end
    end

    context "with invalid params" do
      it "returns unprocessable_entity" do
        post "/api/v1/batches",
             params: { batch: { name: "" } },
             headers: auth_headers(school_admin)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to be_present
      end
    end

    context "when not authenticated" do
      it "returns unauthorized" do
        post "/api/v1/batches",
             params: { batch: { name: "Batch A", course_id: course.id } }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
