class TripsController < ApplicationController
  def new
    redirect_to root_path unless current_user
    @trip = Trip.new
  end

  def index
    @trips = current_user.trips
  end

  def edit
    @trip = current_user.trips.find(params[:id])
  end

  def update
    trip = current_user.trips.find(params[:id])
    trip_params = params[:trip]
    if trip.update(:name => trip_params[:name],
          :description => trip_params[:description],
          :starts_on => Date.parse(trip_params[:starts_on]),
          :ends_on => Date.parse(trip_params[:ends_on]))
      redirect_to trip, notice: "Trip Updated!"
    else
      render action: 'edit', notice: "Update Failed!"
    end
  end

  def create
    @trip = current_user.trips.new.create_trip(valid_trip_params)
    @trip.trip_users.new(user_id: current_user.id)

    if @trip.save
      @trip.update_feeds
      flash[:notice] ="Awesome Trip"
      redirect_to trip_path(@trip)
    else
      flash[:notice] = "Unsuccessful.  Please try again. "
      render new_trip_path
    end
  end

  def update_feed
    @trip = Trip.find(params[:trip_id])
    @trip.update_feeds
    redirect_to :back
  end

  def show
    @trip = Trip.find(params[:id])
    if current_user && @trip.user_id == current_user.id
      @owner = true
    end
    @photos = @trip.photos
    @statuses = @trip.statuses
    @checkins = @trip.checkins
    @geojson = @trip.geojson

    #this will move to the API eventually to return json for checkin map
    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def timeline
    @trip = Trip.find(params[:trip_id])
  end

  def dashboard
    if current_user && current_user.trips.any?
      @trips = current_user.trips
    end
  end

private
  def valid_trip_params
    params.require(:trip).permit(:name, :description, :starts_on, :ends_on)
  end
end
