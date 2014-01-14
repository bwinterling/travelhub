module Feeds
  class CheckinsController < ApplicationController
    def connect
    redirect_to CheckinsAPI.connect_url
    end

    def callback
      if params[:code]
	CheckinsAPI.connect(params[:code])
        flash[:notice] = "Connection to #{CHECKIN_PROVIDER} Successful!"
        redirect_to root_path
      else
        flash[:notice] = "Failed to Connect to #{CHECKIN_PROVIDER}"
        redirect_to root_path
      end
    end
  end
end
