# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_10_195718) do

  create_table "playlist_songs", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "song_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "mood"
    t.integer "user_id"
    t.string "name"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "duration_ms"
    t.integer "key"
    t.integer "mode"
    t.integer "time_signature"
    t.float "acousticness"
    t.float "danceability"
    t.float "energy"
    t.float "instrumentalness"
    t.float "liveness"
    t.float "loudness"
    t.float "speechiness"
    t.float "valence"
    t.float "tempo"
    t.string "spotify_id"
    t.string "uri"
    t.string "track_href"
    t.string "analysis_url"
    t.string "artist"
    t.string "title"
    t.string "album"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "first_name"
    t.string "last_name"
  end

end
