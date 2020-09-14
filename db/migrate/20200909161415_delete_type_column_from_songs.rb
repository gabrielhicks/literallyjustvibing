class DeleteTypeColumnFromSongs < ActiveRecord::Migration[6.0]
  def change
    remove_column :songs, :type, :string
  end
end
