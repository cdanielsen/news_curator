require 'pg'

class Source

attr_reader :name, :url

  def initialize attributes
  	@name = attributes[:name]
    @url = attributes[:url]
  end

  def self.all
    results = DB.exec('SELECT * FROM sources;')
    sources = []
    results.each do |result|
      name = result['name']
      url = result['url']
      sources << Source.new({name: name, url: url})
    end
    sources
  end

  def save
    DB.exec("INSERT INTO sources (name, url) VALUES ('#{@name}', '#{@url}');")
  end

  def ==(another_source)
    self.name == another_source.name && self.url == another_source.url
  end

end
