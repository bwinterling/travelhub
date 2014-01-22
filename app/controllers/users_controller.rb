class UsersController < ApplicationController

  def edit
    @photos_api = PhotosAPI
    @checkins_api = CheckinsAPI
  end

  def index
  end
end
