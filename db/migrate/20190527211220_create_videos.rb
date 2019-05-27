class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :video_uid
      t.text :song

      t.timestamps
    end
  end
end
