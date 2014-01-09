module Feeds
  class PhotosController < ApplicationController
    #check initializers/feeds.rb for setup info
    def connect
      redirect_to PhotosAPI.connect_url
    end

    def callback
      #i'd rather check response codes for error status?
      if params[:code] != nil
        PhotosAPI.callback(params[:code], current_user.id)
        #redirect to feed sign up page!!
        redirect_to root_path
        flash[:notice] = "Connection to #{PHOTO_PROVIDER} Successful!"
      else
        #redirect to feed sign up page!!
        redirect_to root_path
        flash[:notice] = "Failed to Connect to #{PHOTO_PROVIDER}"
      end
    end

  end
end
