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
    authors_ids = @posts.map { |post| post.user_id }
    @authors_names = authors_ids.map { |author_id| User.find(author_id).name }
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
