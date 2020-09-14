# Literally Just Vibing

**Literally Just Vibing** is a command-line application (CLI) that utilizes Spotify's Web API to create playlists based on moods. We interpreted Spotify's track audio features and executed methods to create mood-based playlists with 20 unique songs. Users are able to make multiple playlists based on a list of four moods, refresh a playlist if they dislike what the app creates for them, and save playlists using unique names. Users are also able to delete playlists from their library. The app saves playlists for later access.

## Instructions
Fork and clone this repository from https://github.com/gabrielhicks/literally_just_vibing
1. `$ bundle install` to get dependencies
2. `$ ruby ./bin/run`
3. ?????
4. Profit

## Usage
- Sign up or log in with a username, password, and first & last name. Information is case-sensitive.
- Choose between menu options using arrow keys to either:
    * create a new playlist
    * view your existing playlists
    * delete a playlist from your library
    * exit program
- All interaction with the app is done using arrow keys and the enter key, with the exception of:
    * View My Playlists
    * Delete A Playlist
- The above options require a user to type in the name of the playlist they wish to either view or delete. Information is case-sensitive.
---

## Technologies Used
- Ruby
- ActiveRecord
- Sqlite3
- Spotify's Web API
- JSON
- RESTClient gem
- Rake
- TTYToolkit gems
- colorize gem

---
## Authors

* **Jake Fromm** - https://github.com/jakeFromm
* **Gabriel Hicks** - https://github.com/gabrielhicks/

## License

This project was created in accorance with the Spotify Developer Terms of Service: https://developer.spotify.com/terms/
