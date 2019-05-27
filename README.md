
 * I generated a rails 5 api application that uses mysql database and with rspec testing framework  using requests test

 * i synced up the video_data in the rails console, using this method below
     video_data= JSON.parse(File.read('video-data.json'))

     video_data.each do|video|
       Video.create(video.to_h)
      end


* you can view all the json data by visiting localhost:3000/videos

* unfortunately, i do not have time to do any frontend work, 

* if i was to consume the data in the frontend, i would have use React with  Active-model-serializer   gem  to serializer the json data . i will also use Axios javascript library on React size to get the data from the backend.

Thanks
