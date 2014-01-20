class Api::V1::CheckinsController < ApplicationController
  
  def index
    @data = location_data
    render json: @data, status: 200
  end

  def create
    checkin_params = params[:checkin]
    user = User.find_by(checkin_params[:user_id])
    @checkin = user.checkins.new
    @checkin.venue_name = checkin_params[:venue_name]
    @checkin.venue_street_address = checkin_params[:venue_street_address]
    @checkin.venue_latitude = checkin_params[:venue_latitude]
    @checkin.venue_longitude = checkin_params[:venue_longitude]
    @checkin.shout = checkin_params[:shout]
    @checkin.checkins_at = checkin_params[:checkins_at]
    @checkin.save
      render json: @checkin, status: 201
  end

  def location_data
    @checkins = Checkin.all
    @checkins.map do |checkin|
      if @checkins.count > 0
        {
          type: 'Feature',
          properties: {
                  name: checkin.venue_name,
                  address: checkin.venue_street_address,
                  comment: checkin.shout,
                  checkin_at: checkin.checkins_at
          },
        geometry: {
              type: 'Point',
              coordinates: [ checkin.venue_longitude, checkin.venue_latitude]
          }
        }
      end
    end.compact
  end
end

#in checkin index, pass in parameteres that need

