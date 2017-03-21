class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.author = current_user.full_name
    # byebug
    @post = Post.find(comment_params[:post_id])

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end