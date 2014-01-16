class InviteController < ApplicationController

  def new
    @invite = Invite.new(params[:trip_id])
  end

  def create
    invite_params = params[:invite]
    handle = invite_params[:handle]
    name = invite_params[:name]
    message = invite_params[:message]
    #send a tweet!
    #update usertrip and user tables
    flash[:notice] = "Your invite to #{handle} was sent via Twitter"
    redirect_to trip_path(params[:trip_id])
  end

end
