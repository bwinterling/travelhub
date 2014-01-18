class Api::V1::CheckinController < ApplicationController
  respond_to :json

  def index
    @checkins = Checkins.all
    repond_with @checkins
  end

  def create
    checkin_params =  params[:checkins]
    @checkin = User.
    @checkin.venue = status_params[:venue]
    @checkin.street_address = status_params[:street_address]
    @checkin.save
      render status: 201, json: @status
  end

  def show
    @checkin = Checkin.find(params[:id])
    respond_with @checkin
  end

  def city_map_data
    checkins = Checkin.all
    checkins.map do |checkin|
      if checkin.count > 0
        {
            type: 'Feature',
            properties: {
                    name: 'checkin.venue_name',
                    'marker-color': '#ee7600',
                    'marker-size': 'medium',
                    address: 'checkin.venue_street_address',
                    comment: 'checkin.shout',
                    checkin_at: 'checkin.checkins_at'
            },
          geometry: {
                type: 'Point',
                coordinates: [ checkin.venue_longitude, checkin.venue_latitude]
            }
        }
end
