class UsersController < ApplicationController

  def edit
    @photos_api = PhotosAPI
  end

  def index
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new
  #   @user.name = params[:user][:name]
  #   @user.email = params[:user][:email]
  #   @user.save
  #   session[:email] = @user.email
  #   redirect_to root_path
  # end
  #

end
