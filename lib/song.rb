class Song
  attr_accessor :id, :name, :album

  def initialize(name:, album:)
    @name = name
    @album = album
    @id = nil
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS songs (id INTEGER PRIMARY KEY, name TEXT, album TEXT)")
  end

  def save
    DB[:conn].execute("INSERT INTO songs (name, album) VALUES (?, ?)", @name, @album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    self
  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
    song
  end
end
