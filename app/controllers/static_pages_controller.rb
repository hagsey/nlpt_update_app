class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :welcome
  def welcome
  end
  
  def home
    @posts = Post.order("created_at").limit(15)
    @updates = Update.order("created_at").limit(15)
    @comments = Comment.order("created_at DESC").limit(15)
  end
end
