class SessionsController < ApplicationController
  before_action :current_user

  def new
  end

  def create
    session[:email] = params[:email]
    redirect_to root_path
  end

  def destroy
    session[:email] = nil
    redirect_to root_path
  end
end
