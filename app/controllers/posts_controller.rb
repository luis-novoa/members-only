class PostsController < ApplicationController
  before_action :logged_user?, only: [:new, :create]

  def new
  end

  def create
  end

  def index
  end
end
