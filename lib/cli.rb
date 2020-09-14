require "tty-prompt"
require "tty-box"
require "colorize"

class Cli

    def start
        system("clear")
        self.welcome_screen
        @user = self.login
        system("clear")
        self.main_menu
        system("clear")
        self.exit_app
    end

    def welcome_screen
        self.signature
    end

    def login
        prompt = TTY::Prompt.new
            selection = prompt.select("Hello! Please sign up, or sign in:") do |menu|
                menu.choice name: "New User".colorize(:green), value: 1
                menu.choice name: "Existing User".colorize(:green), value: 2
                menu.choice name: "Exit".colorize(:red), value: 3
            end
                if selection == 1
                    @user = User.create_user
                elsif selection == 2
                    @user = User.existing_user
                elsif selection == 3
                    self.exit_app
                end
    end

    def main_menu
        @user.playlists.reload
        system("clear")
        prompt = TTY::Prompt.new
            selection = prompt.select("Hello #{@user.first_name}! What would you like to do?") do |menu|
                menu.choice name: "Create New Playlist by Mood".colorize(:green), value: 1
                menu.choice name: "View My Playlists".colorize(:green), value: 2
                menu.choice name: "Delete A Playlist".colorize(:green), value: 3
                menu.choice name: "Exit".colorize(:red), value: 4
            end
                if selection == 1
                    self.create_playlist
                elsif selection == 2
                    self.view_playlists
                elsif selection == 3
                    self.delete_playlist
                elsif selection == 4
                    self.exit_app
                end
    end

    def create_playlist
        system("clear")
        prompt = TTY::Prompt.new
            selection = prompt.select("Would you like to make a playlist to set the mood or match your current mood?") do |menu|
                menu.choice name: "Set the mood".colorize(:green), value: 1
                menu.choice name: "Match my mood".colorize(:green), value: 2
                menu.choice name: "Playlist Menu".colorize(:green), value: 3
                menu.choice name: "Exit".colorize(:red), value: 4
            end
            if selection == 1
                self.set_mood
            elsif selection == 2
                self.match_mood
            elsif selection == 3
                self.main_menu
            elsif selection == 4
                self.exit_app
            end
    end

    def set_mood
        system("clear")
        prompt = TTY::Prompt.new
            selection = prompt.select("How would you like to feel?") do |menu|
                menu.choice name: "Stoked".colorize(:blue), value: 1
                menu.choice name: "Chill".colorize(:green), value: 2
                menu.choice name: "Bummed".colorize(:orange), value: 3
                menu.choice name: "Totally PO'd".colorize(:red), value: 4
            end    
            if selection == 1
                self.create_stoked_playlist
            elsif selection == 2
                self.create_chill_playlist
            elsif selection == 3
                self.create_bummed_playlist
            elsif selection == 4
                self.create_angry_playlist
            end
    end

    def match_mood
        system("clear")
        prompt = TTY::Prompt.new
            selection = prompt.select("How are you feeling?") do |menu|
                menu.choice name: "Stoked".colorize(:blue), value: 1
                menu.choice name: "Chill".colorize(:green), value: 2
                menu.choice name: "Bummed".colorize(:orange), value: 3
                menu.choice name: "Totally PO'd".colorize(:red), value: 4
            end
            if selection == 1
                self.create_stoked_playlist
            elsif selection == 2
                self.create_chill_playlist
            elsif selection == 3
                self.create_bummed_playlist
            elsif selection == 4
                self.create_angry_playlist
            end
    end

    def create_stoked_playlist
        system("clear")
        stoked_array = Song.all.select{|song| song.valence > 0.75 && song.energy > 0.75 && song.danceability > 0.75}
        stoked_playlist = Playlist.create(mood: "stoked", user_id: @user.id, name: nil)
        stoked_array.sample(20).each { |song| PlaylistSong.create(playlist_id: stoked_playlist.id, song_id: song.id) }
        puts "Here's your playlist!"
        stoked_playlist.songs.each_with_index do |song, index|
            puts "#{index + 1}. \"#{song.title}\" by #{song.artist}"
        end
        prompt = TTY::Prompt.new
            selection = prompt.select("What would you like to do?") do |menu|
                menu.choice name: "Save this playlist".colorize(:green), value: 1
                menu.choice name: "Refresh playlist with new songs".colorize(:green), value: 2
            end
            if selection == 1
                prompt = TTY::Prompt.new
                    name = prompt.ask("What would you like to call this playlist?")
                    stoked_playlist.update(name: name)
                    box = TTY::Box.success("#{stoked_playlist.name} has been added to your playlists")
                    print box
                    sleep(3)
                self.main_menu
            elsif selection == 2
                @user.playlists.destroy(stoked_playlist)
                create_stoked_playlist
            end
    end

    def create_chill_playlist
        system("clear")
        chill_array = Song.all.select{|song| song.valence > 0.75 && song.energy < 0.5}
        chill_playlist = Playlist.create(mood: "chill", user_id: @user.id, name: nil)
        chill_array.sample(20).each { |song| PlaylistSong.create(playlist_id: chill_playlist.id, song_id: song.id) }
        puts "Here's your playlist!"
        chill_playlist.songs.each_with_index do |song, index|
            puts "#{index + 1}. \"#{song.title}\" by #{song.artist}"
        end
        prompt = TTY::Prompt.new
            selection = prompt.select("What would you like to do?") do |menu|
                menu.choice name: "Save this playlist".colorize(:green), value: 1
                menu.choice name: "Refresh playlist with new songs".colorize(:green), value: 2
            end
            if selection == 1
                prompt = TTY::Prompt.new
                    name = prompt.ask("What would you like to call this playlist?")
                    chill_playlist.update(name: name)
                    box = TTY::Box.success("#{chill_playlist.name} has been added to your playlists")
                    print box
                    sleep(3)
                self.main_menu
            elsif selection == 2
                @user.playlists.destroy(chill_playlist)
                create_chill_playlist
            end
    end

    def create_angry_playlist
        system("clear")
        angry_array = Song.all.select{|song| song.valence < 0.5 && song.energy > 0.75 && song.loudness > -5}
        angry_playlist = Playlist.create(mood: "angry", user_id: @user.id, name: nil)
        angry_array.sample(20).each { |song| PlaylistSong.create(playlist_id: angry_playlist.id, song_id: song.id) }
        puts "Here's your playlist!"
        angry_playlist.songs.each_with_index do |song, index|
            puts "#{index + 1}. \"#{song.title}\" by #{song.artist}"
        end
        prompt = TTY::Prompt.new
            selection = prompt.select("What would you like to do?") do |menu|
                menu.choice name: "Save this playlist".colorize(:green), value: 1
                menu.choice name: "Refresh playlist with new songs".colorize(:green), value: 2
            end
            if selection == 1
                prompt = TTY::Prompt.new
                    name = prompt.ask("What would you like to call this playlist?")
                    angry_playlist.update(name: name)
                    box = TTY::Box.success("#{angry_playlist.name} has been added to your playlists")
                    print box
                    sleep(3)
                self.main_menu
            elsif selection == 2
                @user.playlists.destroy(angry_playlist)
                create_angry_playlist
            end
    end

    def create_bummed_playlist
        system("clear")
        bummed_array = Song.all.select{|song| song.valence < 0.3 && song.energy < 0.5}
        bummed_playlist = Playlist.create(mood: "bummed", user_id: @user.id, name: nil)
        bummed_array.sample(20).each { |song| PlaylistSong.create(playlist_id: bummed_playlist.id, song_id: song.id) }
        puts "Here's your playlist!"
        bummed_playlist.songs.each_with_index do |song, index|
            puts "#{index + 1}. \"#{song.title}\" by #{song.artist}"
        end
        prompt = TTY::Prompt.new
            selection = prompt.select("What would you like to do?") do |menu|
                menu.choice name: "Save this playlist".colorize(:green), value: 1
                menu.choice name: "Refresh playlist with new songs".colorize(:green), value: 2
            end
            if selection == 1
                prompt = TTY::Prompt.new
                    name = prompt.ask("What would you like to call this playlist?")
                    bummed_playlist.update(name: name)
                    box = TTY::Box.success("#{bummed_playlist.name} has been added to your playlists")
                    print box
                    sleep(3)
                self.main_menu
            elsif selection == 2
                @user.playlists.destroy(bummed_playlist)
                create_bummed_playlist
            end
    end

    def view_playlists 
        @user.playlists.reload
        system("clear")
        if @user.playlists.length == 0
            box = TTY::Box.error("You don't have any playlists! Sending you back to the main menu")
            print box
            sleep(3)
            self.main_menu
        else
            prompt = TTY::Prompt.new
            @user.playlists.all.each_with_index do |playlist, index|
                puts "#{index + 1}. #{playlist.name}".colorize(:green)
            end
            view_this = nil
            until view_this != nil
                print "Please enter the name of the playlist you would like to view:"
                print self.spacing
                name = STDIN.gets.chomp()
                view_this = @user.playlists.find_by(name: name)
            end
            view_this.songs.each_with_index do |song, index|
                puts "#{index + 1}. \"#{song.title}\" by #{song.artist}"
            end
            box = TTY::Box.info("Press any key to return to the Main Menu")
            print box
            prompt.keypress
            self.main_menu
        end
    end

    def delete_playlist
        system("clear")
        if @user.playlists.length == 0
            box = TTY::Box.error("You don't have any playlists! Sending you back to the main menu")
            print box
            sleep(3)
            self.main_menu
        else    
            @user.playlists.all.each_with_index do |playlist, index|
                puts "#{index + 1}. #{playlist.name}".colorize(:green)
            end
            delete_this = nil
            until delete_this != nil
                print "Please enter the name of the playlist you would like to delete:"
                print self.spacing
                name = gets.chomp
                delete_this = @user.playlists.find_by(name: name)
            end
            box = TTY::Box.success("#{delete_this.name} has been deleted from your playlists")
            print box
            @user.playlists.destroy(delete_this)
            sleep(3)
            self.main_menu
        end
    end

    def thank_you
        puts <<-'EOF'
d888888P dP                         dP          dP    dP                  
   88    88                         88          Y8.  .8P                  
   88    88d888b. .d8888b. 88d888b. 88  .dP      Y8aa8P  .d8888b. dP    dP
   88    88'  `88 88'  `88 88'  `88 88888"         88    88'  `88 88    88
   88    88    88 88.  .88 88    88 88  `8b.       88    88.  .88 88.  .88
   dP    dP    dP `88888P8 dP    dP dP   `YP       dP    `88888P' `88888P'
        EOF
    end

    def for_using
        puts <<-'EOF'
 88888888b                      dP     dP          oo                  
 88                             88     88                              
a88aaaa    .d8888b. 88d888b.    88     88 .d8888b. dP 88d888b. .d8888b.
 88        88'  `88 88'  `88    88     88 Y8ooooo. 88 88'  `88 88'  `88
 88        88.  .88 88          Y8.   .8P       88 88 88    88 88.  .88
 dP        `88888P' dP          `Y88888P' `88888P' dP dP    dP `8888P88
                                                                    .88
                                                                d8888P 
        EOF
    end

    def signature
        puts <<-'EOF'
dP        oo   dP                              dP dP                    dP                     dP      dP     dP oo dP       oo                  
88             88                              88 88                    88                     88      88     88    88                           
88        dP d8888P .d8888b. 88d888b. .d8888b. 88 88 dP    dP           88 dP    dP .d8888b. d8888P    88    .8P dP 88d888b. dP 88d888b. .d8888b.
88        88   88   88ooood8 88'  `88 88'  `88 88 88 88    88           88 88    88 Y8ooooo.   88      88    d8' 88 88'  `88 88 88'  `88 88'  `88
88        88   88   88.  ... 88       88.  .88 88 88 88.  .88    88.  .d8P 88.  .88       88   88      88  .d8P  88 88.  .88 88 88    88 88.  .88
88888888P dP   dP   `88888P' dP       `88888P8 dP dP `8888P88     `Y8888'  `88888P' `88888P'   dP      888888'   dP 88Y8888' dP dP    dP `8888P88
                                                          .88                                                                                 .88
                                                      d8888P                                                                              d8888P 
        EOF
    end

    def goodnight
        puts <<-'EOF'
dP                                        
88                                        
88        .d8888b. dP   .dP .d8888b.      
88        88'  `88 88   d8' 88ooood8      
88        88.  .88 88 .88'  88.  ...    dP
88888888P `88888P' 8888P'   `88888P'    88
                                        .P
        EOF
    end

    def gabrielandjake
        puts <<-'EOF'
 .88888.           dP                oo          dP       d88b              dP          dP               
d8'   `88          88                            88       8`'8              88          88               
88        .d8888b. 88d888b. 88d888b. dP .d8888b. 88       d8b               88 .d8888b. 88  .dP  .d8888b.
88   YP88 88'  `88 88'  `88 88'  `88 88 88ooood8 88     d8P`8b              88 88'  `88 88888"   88ooood8
Y8.   .88 88.  .88 88.  .88 88       88 88.  ... 88     d8' `8bP     88.  .d8P 88.  .88 88  `8b. 88.  ...
 `88888'  `88888P8 88Y8888' dP       dP `88888P' dP     `888P'`YP     `Y8888'  `88888P8 dP   `YP `88888P'
        EOF
    end

    def spacing
        puts <<-'EOF'

        EOF
    end

    def exit_app
        system("clear")
        self.thank_you
        sleep(1)
        self.spacing
        self.for_using
        sleep(1)
        self.spacing
        self.signature
        sleep(1)
        self.spacing
        self.goodnight
        sleep(1)
        self.spacing
        self.gabrielandjake
        sleep(1)
        self.spacing
        exit
    end 

end