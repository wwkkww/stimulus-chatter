class PostsController < ApplicationController
  include CableReady::Broadcaster

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      # setup the DOM mutation (can stack up multiple DOM mutation)
      cable_ready["feed"].insert_adjacent_html(
        selector: "#feed", # target DOM id to be mutated
        position: "afterbegin",
        html: render_to_string(partial: "posts/post", locals: { post: @post })
      )

      # emit broadcast with cable ready
      cable_ready.broadcast
      
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
