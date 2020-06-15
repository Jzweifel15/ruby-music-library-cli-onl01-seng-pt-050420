class MusicLibraryController
  
    attr_reader :path
    
    def initialize(path = './db/mp3s') 
      @path = path
      MusicImporter.new(@path).import
    end
    
    def call 
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      while true
        input = gets.strip
        case input
        when "exit"
          break;
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "play song"
          play_song
        when "list artist"
          list_artist
        when "list genre"
          list_genre
        else
          puts "Unknown command.  Please try again, or 'exit' to quit."
        end
      end
  
    end
    
    def list_songs
      sorted_songs = Song.all.sort_by {|song| song.name}
      sorted_songs.each {|song|
        puts "#{sorted_songs.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end
    
    def list_artists
      sorted_artists = Artist.all.sort_by {|artist| artist.name}
      sorted_artists.each {|artist|
        puts "#{sorted_artists.index(artist) + 1}. #{artist.name}"}
    end
    
    def list_genres
      sorted_genres = Genre.all.osrt_by {|genre| genre.name}
      sorted_genres.each {|genre|
        puts "#{sorted_genres.index(genre) + 1}. #{genre.name}"}
    end
    
    def list_songs_by_artist
    end
    
    def list_songs_by_genre
    end
    
    def play_song
      puts "Enter the index of the song you would like to play =>"
      input = gets.strip
  
      if song_index = input.to_i
        song = Song.all[song_index - 1]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    end
    
  end