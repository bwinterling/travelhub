class Api::V1::StatusesController < ApplicationController
  def index
    @statuses = Status.all
    render json: @statuses, status: 200
  end

  def create
    status_params = params[:status]
    user = User.find_by(status_params[:user_id])
    @status = user.statuses.new
    @status.text = status_params[:text]
    @status.sent_at = status_params[:sent_at]
    @status.save
    render json: @status, status: 201
  end
end
