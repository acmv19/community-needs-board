require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    let!(:user) { User.create!(name: "ana", email: "ana@gmail.com", password: "ana123") }
    let!(:post1) { Post.create!(title: "Post One", content: "test for post one", user: user) }
    let!(:post2) { Post.create!(title: "Post Two", content: "test for post two", user: user) }

    it "returns a 200 OK status" do
      get posts_path
      expect(response).to have_http_status(:ok)
    end

    it "displays all posts" do
      get posts_path
      expect(response.body).to include("Post One")
      expect(response.body).to include("Post Two")
    end
  end

  describe "GET /posts/:id" do
    let!(:user) { User.create!(name: "ana", email: "ana@gmail.com", password: "ana123") }
    let!(:post) { Post.create!(title: "Detailed Post", content: "Detailed post content", user: user) }
    let!(:comment1) { Comment.create!(content: "Great post!", post: post, user: user) }
    let!(:comment2) { Comment.create!(content: "Thanks for sharing", post: post, user: user) }

    it "returns a 200 OK status" do
      get post_path(post)
      expect(response).to have_http_status(:ok)
    end

    it "displays the post content" do
      get post_path(post)
      expect(response.body).to include("Detailed Post")
      expect(response.body).to include("Detailed post content")
      expect(response.body).to include("ana")
    end

    it "displays all comments for the post" do
      get post_path(post)
      expect(response.body).to include("Great post!")
      expect(response.body).to include("Thanks for sharing")
    end
  end
end
