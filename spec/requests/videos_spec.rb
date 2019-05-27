require 'rails_helper'

 RSpec.describe 'videos', type: :request  do 
 	include_context "db_cleanup_each", :transaction

 	describe " user requests list of videos" do

 	    let!(:videos) { (1..5).map {|idx| create(:video)}}

 	    it "returns all the instances" do
 	     	get videos_path
 	     	expect(request.method). to eq("GET")
 	     	expect(response). to have_http_status(:ok)
			expect(response.content_type).to eq('application/json')

			payload= JSON.parse(response.body)

			expect(payload.count).to eq(videos.count)

 	    end
 	 end

 	 describe " a specific video exist" do

			let(:video) { create(:video)}
			let(:bad_id) { 2543156784245}

			it "returns Video when using corret id" do
				get video_path(video.id)
				expect(response).to have_http_status(:ok)

				payload= JSON.parse(response.body)
				

				expect(payload).to have_key("video_uid")
                expect(payload).to have_key("song")
				expect(payload["id"]).to eq(video.id)
				expect(payload["song"]).to eq(video.song)
			end

			it "returns not found when using incorrect ID" do
              get video_path(bad_id)
              
              expect(response).to have_http_status(:not_found)
              expect(response.content_type).to eq("application/json") 

              payload= JSON.parse(response.body)
              expect(payload).to have_key("errors")
              expect(payload["errors"]).to have_key("full_messages")
              expect(payload["errors"]["full_messages"][0]).to include("cannot","#{bad_id}")
            end
		end

		describe "create a new Video" do 
			let(:video) { attributes_for(:video)}

			it "can create a video when provided with song" do
			 post videos_path, params: {video: {video_uid:"ghdggdhjd", song: "my video- 7"}}
			
			 payload=JSON.parse(response.body)
			 
			 expect(response).to have_http_status(:created)
             expect(response.content_type).to eq("application/json")

             #check the payload of the response
              expect(payload).to have_key("video_uid")
              expect(payload).to have_key("song")
              expect(payload["song"]).to eq(video[:song])
              id=payload["id"]

              # verify we can locate the created instance in DB
              expect(Video.find(id).song).to eq(video[:song])
              
			end
		end

		describe "existing Foo" do
			let(:video) { create(:video) }
            let(:new_video_ui) { "testing" }

            it "can update video_uid" do
           #verify name is not yet the new name
           expect(video.video_uid).to_not eq(new_video_ui)

            # change to the new name
           put video_path(video.id), params: {video: {video_uid: new_video_ui}}
           expect(response).to have_http_status(:no_content)

          # verify we can locate the created instance in DB
           expect(Video.find(video.id).video_uid).to eq(new_video_ui)
         end

         it "can be deleted" do
          head video_path(video.id)
          expect(response).to have_http_status(:ok)

          delete video_path(video.id)
          expect(response).to have_http_status(:no_content)

          head video_path(video.id)
          expect(response).to have_http_status(:not_found)
        end
	 end

 end