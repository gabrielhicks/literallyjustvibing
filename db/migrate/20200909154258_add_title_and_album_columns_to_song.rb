class AddTitleAndAlbumColumnsToSong < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :title, :string
    add_column :songs, :album, :string
  end
end
