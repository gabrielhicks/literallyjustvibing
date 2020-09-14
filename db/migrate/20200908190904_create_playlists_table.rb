class CreatePlaylistsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :mood
      t.integer :user_id
    end
  end
end
