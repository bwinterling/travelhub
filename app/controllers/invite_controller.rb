class InviteController < ApplicationController

  def new
    @invite = Invite.new(params[:trip_id])
    @msg = invite_msg
  end

  def create
    provider = StatusesAPI.provider
    invite_params = params[:invite]
    handle = invite_params[:handle]
    if StatusesAPI.valid_handle?(handle)
      message = handle + " " + invite_msg
      trip = Trip.find(params[:trip_id])
      stripped_handle = handle[1..-1].downcase
      user = trip.users.find_by( name: stripped_handle)
      if user
        trip.trip_users.find_by(user_id: user.id).toggle!(:active)
      end
      if user.nil?
        user = trip.users.create(name: stripped_handle)
      end
      trip.save
      StatusesAPI.send_update(current_user, message)
      flash[:notice] = "Your invite to #{handle} was sent via #{provider}"
      redirect_to trip_path(params[:trip_id])
    else
      flash[:notice] = "You need to include a #{provider} handle!"
      render 'invite/new'
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    tripster = trip.trip_users.find_by(user_id: params[:user_id])
    tripster.toggle!(:active)
    removed_user = User.find(params[:user_id])
    flash[:notice] = "@#{removed_user.name} was removed from your trip!"
    redirect_to trip_path(trip)
  end

  def invite_msg
    "Come join my trip on Triptionary!  http://triptionary.tk"
  end

end
