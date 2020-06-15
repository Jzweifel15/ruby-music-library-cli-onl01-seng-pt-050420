class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    self.songs = []
  end
  
  def self.all 
    @@all 
  end 

  def self.destroy_all 
    self.all.clear 
  end 
  
  def self.create(name) 
    artist = Artist.new(name) 
    artist.save 
    artist 
  end

  def save
    self.class.all.push(self)
  end 

  def add_song(song) 
    song.artist = self unless song.artist == self 
    songs.push(song) unless songs.include?(song)
  end

  def genres 
    songs.collect {|song| song.genre}.uniq 
  end 

end 