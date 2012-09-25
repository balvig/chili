class SessionsController < ApplicationController
  def create
    session[:user_id] = User.find_by_name(params[:name]).id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
