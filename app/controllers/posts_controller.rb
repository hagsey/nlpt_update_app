class PostsController < ApplicationController
  before_action :current_post, except: [:index, :new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.author = current_user.full_name

    if @post.save
      flash[:success] = "New post added."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Successfully deleted"
    redirect_to posts_url
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Post successfully updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :asc)
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title,
                                 :body)
  end

  def current_post
    @post = Post.find(params[:id])
  end

end
