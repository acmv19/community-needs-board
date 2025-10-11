class CommentsController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment posted!"
    else
      redirect_to post_path(@post), alert: "Comment can't be empty"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    # only the comment owner can edit
    if @comment.user != current_user
      redirect_to post_path(@post), alert: "You can only edit your own comments."
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    # only the comment owner can update
    if @comment.user != current_user
      redirect_to post_path(@post), alert: "You can only edit your own comments."
      return
    end
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    # only the comment owner can delete
    if @comment.user != current_user
      redirect_to post_path(@post), alert: "You can only delete your own comments."
      return
    end
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment deleted succesfully!"
  end
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
