class Api::V1::StatusesController < ApplicationController
   skip_before_filter :verify_authenticity_token
  def index
    @statuses = Status.all
    render json: @statuses, status: 200
  end

  def create
    puts "Asasshdfjalsdfhlasdf \n  #{params} \n"
    status_params = params[:status]
    user = User.find(status_params[:user_id].to_i)
    @status = user.statuses.new
    @status.text = status_params[:text]
    @status.sent_at = status_params[:sent_at]
    if @status.save
      render json: @status, status: 201
    else
      render json: "Fail", status: 400
    end
  end
end
