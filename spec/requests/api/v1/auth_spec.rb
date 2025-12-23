
require 'rails_helper'

RSpec.describe "API::V1::Auth::Login", type: :request do
  let!(:admin) do
    create(
      :admin_user,
      email: "admin@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  describe "POST /api/v1/auth/login" do
    context "with valid credentials" do
      it "returns token and user details" do
        post "/api/v1/auth/login",
             params: { email: admin.email, password: "password123" }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["token"]).to be_present
        expect(json["user"]["role"]).to eq("admin")
      end
    end

    context "with invalid password" do
      it "returns unauthorized" do
        post "/api/v1/auth/login",
             params: { email: admin.email, password: "wrong" }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end


# require 'rails_helper'

# RSpec.describe "API::V1::Auth::Login", type: :request do
#   # let!(:admin) do
#   #   User.create!(
#   #     school: create(:school),
#   #     email: "admin@example.com",
#   #     password: "password123",
#   #     password_confirmation: "password123",
#   #     role: :admin
#   #   )
#   # end
#   let!(:user) do
#   create(
#     :admin_user,
#     email: "admin@example.com",
#     password: "password123",
#     password_confirmation: "password123"
#   )
# end


#   describe "POST /api/v1/auth/login" do
#     context "with valid credentials" do
#       let(:user) do
#         create(:user, created_by: admin)
#       end

#       it "returns token and user details" do
#         post "/api/v1/auth/login", params: { email: user.email, password: "password123" }
#         expect(response).to have_http_status(:ok)
#         json = JSON.parse(response.body)
#         expect(json["token"]).to be_present
#         expect(json["user"]["role"]).to eq("student")
#       end
#     end

#     context "with invalid password" do
#       let(:user) { create(:user, created_by: admin) }

#       it "returns unauthorized" do
#         post "/api/v1/auth/login", params: { email: user.email, password: "wrong" }
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end
#   end
# end