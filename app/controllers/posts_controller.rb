class PostsController < ApplicationController

  before_action :logged_user?, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to '/posts'
  end

  def index
    @posts = Post.all
    @authors.map(@posts.user_id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
