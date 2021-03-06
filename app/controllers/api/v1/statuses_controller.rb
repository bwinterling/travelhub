class Api::V1::StatusesController < ApplicationController
   skip_before_filter :verify_authenticity_token
  def index
    @statuses = Status.all
    render json: @statuses, status: 200
  end

  def d(text)
    unless Rails.env.production?
      puts text
    end
  end

  def create
    status_params = params[:status]

    d("These are the params #{status_params}")
    statuses = Status.where(user_id: status_params[:user_id], text: status_params[:text],
				  sent_at: status_params[:sent_at], origin_id:status_params[:origin_id].to_s)
      d "the statuses count is #{statuses.count}"
    if statuses.count > 0

      @status =  statuses.first
      d "found #{@status.text}"
    else
      @status = Status.create(user_id: status_params[:user_id], text: status_params[:text],
				sent_at: status_params[:sent_at], origin_id: status_params[:origin_id].to_s)
      d "creating #{@status.text}"
    end

    d "status done"

    unless  @status.nil?
      render json: @status, status: 201
    else
      render json: "Fail", status: 400
    end
  end
end
