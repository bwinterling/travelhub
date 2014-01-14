class SessionsController < ApplicationController
  before_action :current_user

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to edit_user_path(current_user), notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:error] = "Signed out!"
  end
end
