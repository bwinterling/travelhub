class InviteController < ApplicationController

  def new
    @invite = Invite.new(params[:trip_id])
    trip = Trip.find(params[:trip_id])
    @msg = invite_msg(trip.name)
  end

  def create
    provider = StatusesAPI.provider
    invite_params = params[:invite]
    handle = invite_params[:handle]
    if StatusesAPI.valid_handle?(handle)
      trip = Trip.find(params[:trip_id])
      message = handle + " " + invite_msg(trip.name)
      stripped_handle = handle[1..-1].downcase
      user = User.find_or_create_by(name: stripped_handle)
      if  trip.users.include? user
	trip_user = trip.trip_users.find_by(user_id: user.id)
	trip_user.active = true
	trip_user.save!
      else
	trip.users <<  user
      end
      #if user
      #  trip_user = trip.trip_users.find_by(user_id: user.id)
      #  trip_user.toggle!(:active) if trip_user
      #end
      #if user.nil?
      #  user = trip.users.create(name: stripped_handle)
      #end
      trip.save!
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

  def invite_msg(trip_name)
    "Come join trip #{trip_name} on Triptionary! http://triptionary.tk"
  end

end
