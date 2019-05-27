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

 end