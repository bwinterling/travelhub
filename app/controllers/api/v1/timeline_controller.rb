class Api::V1::TimelineController < ApplicationController
  respond_to :json

  def show
    @timeline = Timeline.new(params[:id])
    respond_with @timeline.return_json
  end
end
