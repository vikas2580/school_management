require 'rails_helper'

RSpec.describe "API::V1::EnrollmentRequests", type: :request do
  let(:admin)        { create(:admin_user) }
  let(:school)       { create(:school, created_by: admin) }
  let(:course)       { create(:course, school: school) }
  let(:batch)        { create(:batch, course: course) }

  let(:student)      { create(:user) }
  let(:school_admin) { create(:school_admin_user, school: school) }

  describe "POST /api/v1/enrollment_requests" do
    it "creates enrollment request by student" do
      post "/api/v1/enrollment_requests",
           params: { batch_id: batch.id },
           headers: auth_headers(student)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/enrollment_requests/:id" do
    let(:request_record) do
      create(:enrollment_request, student: student, batch: batch)
    end
  end
end
