class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Account created successfully'
      log_in(@user)
      redirect_to posts_url
    else
      render 'users/new'
    end
  end

  def index
    @user = User.new
    render 'users/new'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
