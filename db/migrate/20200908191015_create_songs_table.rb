class CreateSongsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.integer :duration_ms
      t.integer :key
      t.integer :mode
      t.integer :time_signature
      t.float :acousticness
      t.float :danceability
      t.float :energy
      t.float :instrumentalness
      t.float :liveness
      t.float :loudness
      t.float :speechiness
      t.float :valence
      t.float :tempo
      t.string :spotify_id
      t.string :uri
      t.string :track_href
      t.string :analysis_url
      t.string :type
    end
  end
end
