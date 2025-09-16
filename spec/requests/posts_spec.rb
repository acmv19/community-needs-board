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

   describe "GET /posts/:id/edit and PATCH /posts/:id" do
    let!(:user) { User.create!(name: "ana", email: "ana@gmail.com", password: "ana123") }
    let!(:other_user) { User.create!(name: "bob", email: "bob@gmail.com", password: "bob123") }
    let!(:post) { Post.create!(title: "Original Title", content: "Original content", user: user) }

    describe "GET /posts/:id/edit" do
      context "as the post owner" do
        before do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        end

        it "renders the edit form" do
          get edit_post_path(post)
          expect(response).to have_http_status(:ok)
          expect(response.body).to include("Edit Post")
          expect(response.body).to include("Original Title")
        end
      end

      context "as a different user" do
        before do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)
        end

        it "redirects with an alert" do
          get edit_post_path(post)
          expect(response).to redirect_to(posts_path)
        end
      end
    end

    describe "PATCH /posts/:id" do
      context "as the post owner" do
        before do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        end

        it "updates the post successfully" do
          patch post_path(post), params: { post: { title: "Updated Title", content: "Updated content" } }
          expect(response).to redirect_to(post_path(post))
          expect(post.reload.title).to eq("Updated Title")
        end
      end

      context "as a different user" do
        before do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)
        end

        it "does not update the post" do
          patch post_path(post), params: { post: { title: "Hacked Title" } }
          expect(response).to redirect_to(posts_path)
          expect(post.reload.title).to eq("Original Title")
        end
      end
    end
  end
end
