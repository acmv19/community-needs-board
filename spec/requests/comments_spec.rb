require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { User.create(name: "Ana", email: "ana@gmail.com", password: "ana123") }
  let!(:post_record) { Post.create(title: "Test Post", content: "This is a test post", user: user) }

  describe "POST /posts/:post_id/comments" do
    it "creates a comment for a post when user is logged in" do
      # Primero, hacemos login "real"
      post "/login", params: { email: user.email, password: "ana123" }
      follow_redirect! # sigue el redirect después del login si lo hay

      # Ahora hacemos el POST al comentario
      post "/posts/#{post_record.id}/comments", params: { comment: { content: "Nice post!" } }

      # Verificamos que se haya redirigido al post
      expect(response).to redirect_to(post_path(post_record))

      # Seguimos la redirección para verificar contenido
      follow_redirect!

      # Verificamos que el comentario aparezca en la vista
      expect(response.body).to include("Nice post!")
    end

    it "does not allow creating a comment when not logged in" do
      post "/posts/#{post_record.id}/comments", params: { comment: { content: "Should not post" } }
      expect(response).to redirect_to(login_path)
    end
  end
end
