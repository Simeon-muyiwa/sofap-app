FactoryBot.define do 
	factory :video do
		sequence(:video_uid) { |n| "hsgdhhhghsdg #{n}"}
		sequence(:song) { |n| "my video- #{n}"}
	end
end