class PostsController < ApplicationController
before_action :require_login, only: [ :new, :create, :edit, :update, :destroy ]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new
    end
  end

 def edit
  @post = Post.find(params[:id])
  if @post.user != current_user
    redirect_to posts_path, alert: "You can only edit your own posts."
  end
end

 def update
  @post = Post.find(params[:id])
  if @post.user != current_user
    redirect_to posts_path, alert: "You can only edit your own posts."
    return
  end

  if @post.update(post_params)
    redirect_to @post, notice: "Post updated successfully."
  else
    render :edit, status: :unprocessable_content
  end
end


  def destroy
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_path, alert: "You can only delete your own posts."
      return
    end
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
