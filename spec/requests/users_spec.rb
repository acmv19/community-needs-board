require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "returns 200 ok success" do
      get "/users/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new user" do
      post "/users", params: { user: { name: "Test User", email: "test@example.com", password: "password" } }

      expect(User.last.email).to eq("test@example.com")
      expect(session[:user_id]).to eq(User.last.id)
      expect(response).to redirect_to(posts_path)
    end
  end
end
