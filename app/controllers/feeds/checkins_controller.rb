module Feeds
  class CheckinsController < ApplicatioController
    def connect
    redirect_to CheckinsAPI.connect_url
    end

    def callback
      if params[:code]
      else
      end
    end
  end
end
