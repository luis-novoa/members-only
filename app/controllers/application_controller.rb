class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
    user.assign_token
    user.update(remember_digest: user.remember_digest)
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_digest] = user.remember_digest
    define_user(user)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def define_user(user)
    @current_user = user
  end

  def log_out
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_digest)
    define_user(nil)
  end

  def logged_user?
    redirect_to root_url if session[:user_id].nil?
  end
end
