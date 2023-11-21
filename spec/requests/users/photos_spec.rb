require 'rails_helper'

RSpec.describe "Users::Photos", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/users/photos/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
