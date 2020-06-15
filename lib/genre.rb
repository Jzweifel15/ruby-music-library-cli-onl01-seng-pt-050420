class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    self.songs = []
    @name = name
  end
  
  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def save
    self.class.all.push(self)
  end

  def add_song(song)
    song.genre = self unless song.genre == self
    songs.push(song) unless songs.include?(song)
  end

  def artists
    songs.collect {|song| song.artist }.uniq
  end
  
end