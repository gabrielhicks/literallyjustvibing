class CreatePlaylistSongsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_songs do |t|
      t.integer :playlist_id
      t.integer :song_id
    end
  end
end
