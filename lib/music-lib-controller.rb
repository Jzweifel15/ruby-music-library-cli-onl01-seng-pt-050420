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
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
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
      sorted_genres = Genre.all.sort_by {|genre| genre.name}
      sorted_genres.each {|genre|
        puts "#{sorted_genres.index(genre) + 1}. #{genre.name}"}
    end
    
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip
      if artist = Artist.find_by_name(input)
        artist.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
          puts "#{index + 1}. #{song.name} - #{song.genre.name}"
        end
      end
    end
    
    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip
      if genre = Genre.find_by_name(input)
        genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
          puts "#{index + 1}. #{song.artist.name} - #{song.name}"
        end
      end
    end
    
    def play_song
      puts "Which song number would you like to play?"
      input = gets.strip.to_i
      if input > 0 && input <= Song.all.length
        array = Song.all.sort{|a, b| a.name <=> b.name}
        song = array[input-1]
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
    
  end