class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post successfully created"
      redirect_to posts_path
    else
      flash[:error] = "Something went wrong"
      render 'index'
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
  
end
