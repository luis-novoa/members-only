class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to posts_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
