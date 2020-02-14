class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user.authenticate(params[:session][:password])
      log_in(@user)
    end
    render 'sessions/new'
  end
end
