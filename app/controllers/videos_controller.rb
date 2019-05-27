class VideosController < ApplicationController
	before_action :set_video, only: [:show, :update, :destroy]

	def index
		@videos = Video.all
		render json: @videos
	end

	def show
		render json: @video
	end

   private

	 def set_video
       @video = Video.find(params[:id])
     end
end