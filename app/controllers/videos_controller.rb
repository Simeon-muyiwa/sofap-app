class VideosController < ApplicationController
	before_action :set_video, only: [:show, :update, :destroy]

	def index
		@videos = Video.all
		render json: @videos
	end

	def show
		render json: @video
	end

	def create
     @video= Video.new(video_params)

     if @video.save
      render json: @video, status: :created, location: @video
     else
      render json: @video.errors, status: :unprocessable_entity
     end
   end

   def update
    @video = Video.find(params[:id])

    if @video.update(video_params)
      head :no_content
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy

    head :no_content
  end





   private

	 def set_video
       @video = Video.find(params[:id])
     end

     def video_params
      params.require(:video).permit(:song, :video_uid) 
     end
end