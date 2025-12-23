require 'rails_helper'

RSpec.describe "Api::V1::Schools", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/schools/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/schools/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/schools/update"
      expect(response).to have_http_status(:success)
    end
  end

end
