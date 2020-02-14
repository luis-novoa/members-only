class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
    user.assign_token
    user.update(remember_digest: user.remember_digest)
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_digest] = user.remember_digest
    define_user(user)
  end

  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find_by(id: session[:user_id])
  #   elsif cookies.signed[:user_id]
  #     user = User.find_by(id: cookies.signed[:user_id])
  #     if user && user.authenticated?(:remember_digest, cookies[:remember_digest])
  #       session[:user_id] = user.id
  #       @current_user = user
  #     end
  #   end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
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
    if session[:user_id].nil?
      redirect_to root_url
    end
  end
end
