require 'pry'
require 'rest-client'
require 'json'
require_relative '../config/environment'

User.destroy_all
Playlist.destroy_all
PlaylistSong.destroy_all

gabe = User.create(first_name: "Gabriel", last_name: "H")
jake = User.create(first_name: "Jake", last_name: "F")

play1 = Playlist.create(mood: "happy", user_id: gabe.id)
play2 = Playlist.create(mood: "sad", user_id: gabe.id)
play3 = Playlist.create(mood: "happy", user_id: jake.id)
play4 = Playlist.create(mood: "sad", user_id: jake.id)

play_song1 = PlaylistSong.create(playlist_id: play1.id, song_id: 1)
play_song2 = PlaylistSong.create(playlist_id: play2.id, song_id: 2)
play_song3 = PlaylistSong.create(playlist_id: play3.id, song_id: 3)
play_song4 = PlaylistSong.create(playlist_id: play4.id, song_id: 4)

high_valence = Song.all.select{|song| song.valence > 0.5}
high_energy = Song.all.select{|song| song.energy > 0.5}
high_valence_high_energy = Song.all.select{|song| song.valence > 0.5 && song.energy > 0.5}
high_v_high_e_playlist1 = Playlist.create(mood: "happy and excited", user_id: jake.id)
high_valence_high_energy.sample(10).each do |song|
    PlaylistSong.create(playlist_id: high_v_high_e_playlist1.id, song_id: song.id)
end

high_v_high_e_playlist2 = Playlist.create(mood: "happy and excited", user_id: gabe.id)
high_valence_high_energy.sample(10).each do |song|
    PlaylistSong.create(playlist_id: high_v_high_e_playlist2.id, song_id: song.id)
end