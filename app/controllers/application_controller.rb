class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
    user.assign_token
    user.update(remember_digest: user.remember_digest)
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_digest] = user.remember_digest
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(:remember_digest, cookies[:remember_digest])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end
end
