module Feeds
class LocationController < ApplicationController
    before_action :current_user
    def connect
      redirect_to LocationsAPI.connect_url
    end

    def callback
      if params[:code] != nil
        LocationsAPI.callback(params[:code], current_user.id)
        redirect_to root_path
        flash[:notice] = "Connection to #{LOCATION_PROVIDER} Successful!"
      else
        redirect_to root_path
        flash[:notice] = "Failed to Connect to #{LOCATION_PROVIDER}"
      end
    end
  end
end

end
