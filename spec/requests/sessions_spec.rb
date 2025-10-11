require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { User.create(name: "Ana", email: "ana@gmail.com", password: "ana123") }

  describe "POST /login" do
    it "logs in the user with correct credentials" do
      post login_path, params: { email: "ana@gmail.com", password: "ana123" }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(posts_path)
    end
  end

  describe "DELETE /logout" do
    it "logs out the user" do
      post login_path, params: { email: "ana@gmail.com", password: "ana123" }
      delete logout_path
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(posts_path)
    end
  end
end
