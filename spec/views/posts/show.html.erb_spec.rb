require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do
  it "displays the post content and comments" do
    user = User.create!(name: "ana", email: "ana@gmail.com", password: "ana123")
    post = Post.create!(title: "Detailed Post", content: "Detailed post content", user: user)
    comment1 = Comment.create!(content: "Great post!", post: post, user: user)
    comment2 = Comment.create!(content: "Thanks for sharing", post: post, user: user)

    assign(:post, post)
    assign(:comments, [ comment1, comment2 ])

    render

    expect(rendered).to include("Detailed Post")
    expect(rendered).to include("Detailed post content")
    expect(rendered).to include("ana")
    expect(rendered).to include("Great post!")
    expect(rendered).to include("Thanks for sharing")
  end
end
