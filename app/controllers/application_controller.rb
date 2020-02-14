class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
    user.assign_token
    user.update(remember_digest: user.remember_digest)
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_digest] = user.remember_digest
  end
end
