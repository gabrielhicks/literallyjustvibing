class AddArtistColumnToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :artist, :string
  end
end
