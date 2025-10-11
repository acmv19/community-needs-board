require 'rails_helper'

RSpec.describe "posts/index.html.erb", type: :view do
  it "displays all posts" do
    assign(:posts, [
      Post.create!(title: "Post One", content: "Content for post one", user: User.create!(name: "ana", email: "ana@gmail.com", password: "ana123")),
      Post.create!(title: "Post Two", content: "Content for post two", user: User.create!(name: "ana", email: "ana2@gmail.com", password: "ana123"))
    ])

    render

    expect(rendered).to include("Post One")
    expect(rendered).to include("Post Two")
  end
end
