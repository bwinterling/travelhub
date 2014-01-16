class Feeds::V1::StatusesController < ApplicationController
  respond_to :json

  def index
    respond_with Status.all
  end
end
