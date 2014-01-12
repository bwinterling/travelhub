class TripsController < ApplicationController
  def new
    redirect_to root_path unless current_user
    @trip = Trip.new
  end

  def create
    trip_params = params[:trip]
    @trip = current_user.trips.new
    @trip.name = trip_params[:name]
    @trip.description = trip_params[:description]
    @trip.starts_at = DateTime.strptime(trip_params[:starts_at], "%d/%m/%Y")
    @trip.ends_at = DateTime.strptime(trip_params[:ends_at], "%d/%m/%Y")

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    if current_user.trips.last
      @trip = current_user.trips.last
      @photos = PhotosAPI.feed_for(current_user.id, @trip.starts_at, @trip.ends_at)
      @tweets = @trip.messages
    else
      flash[:notice] = "You do not have any trips!"
      redirect to root_path
    end
  end
end
