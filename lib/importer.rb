class MusicImporter
  
  attr_reader :path
  
  def initialize(path)
    @path = path
    @files = []
  end
  
  def files
    @files=Dir.glob(self.path+"/*.mp3")
    @files.collect {|file| File.basename(file)}
  end
  
  def import 
    files.each {|filename| Song.create_from_filename(filename)}
  end
  
end