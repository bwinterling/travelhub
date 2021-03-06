module Api
  module V1
    class PhotosController < ApplicationController

      skip_before_filter :verify_authenticity_token
      def index
	@photos = Photo.all
	render json: @photos, status: 200
      end

      def create
	photo_params = params[:photo]
	user = User.find(photo_params[:user_id])

	@photo = user.photos.find_or_create_by(photo_id: photo_params[:photo_id])
	@photo.thumbnail_url = photo_params[:thumbnail_url]
	@photo.standard_url = photo_params[:standard_url]
	@photo.caption = photo_params[:caption]
	@photo.photo_taken = photo_params[:photo_taken]

	if @photo.save
	  render json: @photo, status: 201
	else
	  render json: "Fail", status: 400
	end
      end
    end
  end
end
