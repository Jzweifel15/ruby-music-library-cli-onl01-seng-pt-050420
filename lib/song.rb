class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.new_from_filename(filename)
    parms = filename.split(" - ")
    artist = Artist.find_or_create_by_name(parms[0])
    song = self.new(parms[1])
    songGenre = parms[2].slice(0..parms[2].length-5)
    genre = Genre.find_or_create_by_name(songGenre)
    song.artist = artist
    song.genre = genre
    song
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all.push(self)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

end