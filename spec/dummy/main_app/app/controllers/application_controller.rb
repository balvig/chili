class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    User.last
  end

  def logged_in?
    current_user
  end
end
