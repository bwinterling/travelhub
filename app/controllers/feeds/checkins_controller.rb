module Feeds
  class CheckinsController < ApplicationController
      before_action :current_user

    def connect
      redirect_to CheckinsAPI.connect_url
    end

    def callback
      if params[:code]
	       @client  = CheckinsAPI.callback(params[:code], current_user.id)
        flash[:notice] = "Connection to #{CHECKIN_PROVIDER} Successful!"
      else
        flash[:notice] = "Failed to Connect to #{CHECKIN_PROVIDER}"
      end
        redirect_to root_path
    end
  end
end
