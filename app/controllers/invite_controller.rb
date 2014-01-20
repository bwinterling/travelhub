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
      stripped_handle = handle[1..-1]
      new_user = trip.users.find_or_create_by(name: stripped_handle)
      trip.trip_users.build(user_id: new_user.id)
      trip.save
      #update usertrip and user tables
      StatusesAPI.send_update(current_user, message)
      flash[:notice] = "Your invite to #{handle} was sent via #{provider}"
      redirect_to trip_path(params[:trip_id])
    else
      flash[:notice] = "You need to include a #{provider} handle!"
      render 'invite/new'
    end
  end

  def invite_msg
    "Come join my trip on Triptionary!  http://triptionary.tk"
  end

end
