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
				# pp payload

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

 end