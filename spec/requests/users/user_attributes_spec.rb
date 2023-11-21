require 'rails_helper'

RSpec.describe "Users::UserAttributes", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/users/user_attributes/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/users/user_attributes/update"
      expect(response).to have_http_status(:success)
    end
  end

end
