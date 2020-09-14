require "tty-prompt"
require "tty-box"

class User < ActiveRecord::Base
    has_many :playlists
    has_many :songs, through: :playlists

    def self.create_user
        prompt = TTY::Prompt.new
        name = prompt.ask("Please create a username")
        if User.find_by(username: name) == nil
            prompt = TTY::Prompt.new
            password = prompt.mask("Please create a password")
            full_name = prompt.ask("Please enter your first and last name")
            return User.find_or_create_by(username: name, password: password, first_name: full_name.split(" ").first, last_name: full_name.split(" ").last)
        else
            box = TTY::Box.warn("It appears this username has already been taken")
            print box
            sleep(3)
            User.create_user
        end
    end

    def self.existing_user
        prompt = TTY::Prompt.new
        name = prompt.ask("Please enter your username")
        password = prompt.mask("Please enter your password")
        if User.find_by(username: name, password: password) == nil
            box = TTY::Box.warn("Invalid Username/Password combonation, please try again.")
            print box
            sleep(3)
            User.existing_user
        else
        return User.find_by(username: name, password: password)
        end
    end

end